#!/bin/bash

BASE_DIR="$HOME/Mercury"
DESTINATION="platform=iOS Simulator,name=iPhone 15 Plus"
WORKSPACE_LOC=$(find "$BASE_DIR" -name "workspace.xcworkspace")

test_project() {
   local project_path="$1"
   local workspace="$2"
    
   echo "Listing schemes for project $project_path"
   targets=$(xcodebuild -list -project "$project_path" | awk '/Schemes:/,/^$/' | sed -e '1d;$d')
    
   for target in $targets; do
     if [[ "$target" == *"SampleApp" ]]|| [[ "$target" != *"Tests" ]]; then
       echo "Skipping scheme $target"
       continue
     fi
        
     echo "Testing scheme $target in workspace $workspace"
     pushd "$TEST_BASE" > /dev/null
     xcodebuild test -workspace "$workspace" -scheme "$target" -destination "$DESTINATION"
     local result=$?
     popd > /dev/null
        
     if [ $result -ne 0 ]; then
       echo "Test failed for scheme $target in workspace $workspace"
       exit 1
     fi
   done
}

find "$BASE_DIR" -name "*.xcodeproj" | while read -r project; do
  # Tuist 디렉토리에 포함된 프로젝트는 건너뜀
  if [[ "$project" == *"/Tuist/"* ]]; then
    echo "Skipping project in Tuist directory: $project"
    continue
  fi
  
  echo $project
 
  project_dir=$(dirname "$project")
    
  if [ -n "$WORKSPACE_LOC" ]; then
    test_project "$project" "$WORKSPACE_LOC"
  else
    echo "No workspace found for $project"
  fi
done
