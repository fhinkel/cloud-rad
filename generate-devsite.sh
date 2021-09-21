#!/bin/bash

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Create files to be uploaded to devsite. 
# When running locally, run `docfx --serve` in ./yaml/ after this script


mkdir -p ./etc

cp node_modules/@google-cloud/cloud-rad/api-extractor.json .
npx @microsoft/api-extractor run --local

# install api-documenter deps manually because we're using a forked subdirectory
cd node_modules/@microsoft/api-documenter/
npm install
npm run build
cd ../../..

npx @microsoft/api-documenter yaml --input-folder=temp

# Clean up TOC
# Delete SharePoint item, see https://github.com/microsoft/rushstack/issues/1229
sed -i -e '1,3d' ./yaml/toc.yml
sed -i -e 's/^    //' ./yaml/toc.yml
# Delete interfaces from TOC (name and uid)
sed -i -e '/name: I[A-Z]/{N;d;}' ./yaml/toc.yml
sed -i -e '/^ *\@google-cloud.*:interface/d' ./yaml/toc.yml

## Add "items:" to short toc for overview file
if [[ $(wc -l <./yaml/toc.yml) -le 3 ]] ; then
  sed -i -e '3a\
 \ \ \ items:
' ./yaml/toc.yml
fi

# Add Quickstart section, same as README
sed -i -e '4a\
 \ \ \ \ \ - name: Quickstart
' ./yaml/toc.yml
sed -i -e '5a\
 \ \ \ \ \ \ \ homepage: quickstart.md
' ./yaml/toc.yml

NAME=$(ls temp | sed s/.api.json*//)

# Add package overview section
sed -i -e '6a\
 \ \ \ \ \ - name: Overview
' ./yaml/toc.yml
sed -i -e '7a\
 \ \ \ \ \ \ \ homepage: overview.html
' ./yaml/toc.yml

## Copy everything to devsite
mkdir -p ./_devsite
mkdir -p ./_devsite/$NAME

cp ./yaml/$NAME/* ./_devsite/$NAME || :
cp ./yaml/toc.yml ./_devsite/toc.yml

## Rename the default overview page,
mv ./yaml/$NAME.yml ./_devsite/overview.yml

## readme is not allowed as filename
cp ./README.md ./_devsite/quickstart.md
