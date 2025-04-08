#!/bin/bash

last_args=$@
if [[ $2 == "last" ]] ; then
  spec_file_path=$(cat /tmp/last_spec_args.txt)
else
  echo $last_args > /tmp/last_spec_args.txt
  spec_file_path=$1
fi

# this is used in the case of MiniTest, need to think of a better way
# than -e bin/rspec since plugin repos do not have the bin either.
if [[ 1 == 2 ]]; then
  if [[ ! -e "bin/rspec" ]]; then
    spec_file_path_no_line=$(echo $spec_file_path | cut -d ':' -f 1)
    spec_file_path_line=$(echo $spec_file_path | cut -d ':' -f 2)

    if [[ $spec_file_path_line == $spec_file_path_no_line ]] ; then
      bundle exec ruby -Ilib:test $spec_file_path_no_line
    else
      bundle exec ruby -Ilib:test $spec_file_path_no_line -l $spec_file_path_line
    fi
    exit
  fi
fi

no_headless=$2
is_plugin_spec=false
is_theme_spec=false
is_core_spec=false
rspec_format="--format progress"
selenium_headless=1

while read plugin; do
  if [[ "$spec_file_path" == *"$plugin"*  ]] ; then
    is_plugin_spec=true
  fi

  if [[ "$no_headless" == "noheadless" ]] ; then
    selenium_headless=0
  fi

  if [[ "$spec_file_path" == *"system"* ]] ; then
    rspec_format="--format documentation"
  fi
done < <(ls $HOME/repos/discourse/plugins)

if [ $is_plugin_spec = false ] ; then
  if [[ "$spec_file_path" == *"$HOME/repos/discourse/"*  ]] ; then
    is_core_spec=true
  fi
fi

if [ $is_core_spec = false ] && [ $is_plugin_spec = false ] ; then
  is_theme_spec=true
fi

if [ $is_plugin_spec = true ] || [ $is_theme_spec = true ] ; then
  cd $DISCOURSE_REPO_BASE_DIRECTORY && QUIET_SASS_DEPRECATIONS="1" RUN_S3_SYSTEM_SPECS=1 SELENIUM_HEADLESS=$selenium_headless IMPROVED_SPEC_DEBUGGING=1 LOAD_PLUGINS=1 bin/rspec $spec_file_path $rspec_format
else
  QUIET_SASS_DEPRECATIONS="1" RUN_S3_SYSTEM_SPECS=1 MINIO_RUNNER_LOG_LEVEL=DEBUG SELENIUM_HEADLESS=$selenium_headless IMPROVED_SPEC_DEBUGGING=1 bin/rspec $spec_file_path $spec_format
fi
