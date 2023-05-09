# Automated Segmentation and 3D Reconstruction of Auditory Cortex Layer IV from Histopathology Slides 
Deep Learning Final Project

Code outline 
generate_seg.m: Takes segmentation patches, applies basic post processing, recreates whole image 

createwindow.m: Creates a patch(and corresponding label if given) of a given size

nnUNet_simple.ipybn: nnUNet implementation for this project

preprocess.m: creates patches from raw data 

registerimage.m: aligns and registers whole image for 3D reconstruction 
