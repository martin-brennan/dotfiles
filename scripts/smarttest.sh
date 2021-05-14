#!/bin/bash

spec_file_path=$1
is_plugin_spec=false

while read plugin; do
  if [[ "$spec_file_path" == *"$plugin"*  ]] ; then
    is_plugin_spec=true
  fi
done < <(ls ~/repos/discourse/plugins)

if [ $is_plugin_spec = true  ] ; then
  set -x
  cd ~/repos/discourse && IMPROVED_SPEC_DEBUGGING=1 LOAD_PLUGINS=1 bundle exec rspec $spec_file_path
else
  set -x
  bundle exec rspec $spec_file_path
fi
