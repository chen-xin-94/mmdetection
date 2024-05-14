#!/bin/bash

# Set the DATASET_FOLDER variable to the path of your dataset folder
# DIRECTORY=\$1
DATASET_FOLDER="$HOME/dataset/Pcaps_Birds_Eye/led_radlader_azubi_tag"

# Normalize the DATASET_FOLDER path by removing the user home shortcut
DATASET_FOLDER=$(echo $DATASET_FOLDER | sed "s:~:$HOME:")

# Define the configurations and checkpoints paths
CONFIG_PATH="configs/ssd/ssdlite_mobilenetv2-scratch_8xb24-600e_coco.py"
CHECKPOINT_PATH="checkpoints/ssdlite_mobilenetv2_scratch_600e_coco_20210629_110627-974d9307.pth"

# Loop through all mp4 files in the dataset folder that start with "camera"
# find "$DATASET_FOLDER" -type f -name "camera*.mp4" | while read video_file; do
for video_file in "$DATASET_FOLDER"/camera*.mp4; do
  # Extract the base name without the path and extension
  base_name=$(basename "$video_file" .mp4)
  
  # Extract the subdirectory path after /dataset/
  sub_dir_path=${video_file#*/dataset/}
  sub_dir_path=$(dirname "$sub_dir_path")
  
  # Create the output directory path
  output_dir="outputs/$sub_dir_path"
  
  # Create the output directory if it does not exist
  mkdir -p "$output_dir"
  
  # Construct the output video path
  output_video_path="$output_dir/${base_name}.mp4"
  
  # Run the python script with the constructed paths and options
  python demo/video_demo_tqdm.py \
    "$video_file" \
    "$CONFIG_PATH" \
    "$CHECKPOINT_PATH" \
    --device cuda:1 \
    --out "$output_video_path"
done