import cv2
import numpy as np
from PIL import Image

# Define the path to the input image
input_image_path = "/Users/panagiotis/Coder/AssistedLiving/Image Dancer/tripp.png"

# Convert the input image to JPEG format
converted_image_path = "/Users/panagiotis/Coder/AssistedLiving/Image Dancer/hello.jpeg"
#Image.open(input_image_path).convert("RGB").save(converted_image_path, "JPEG")

# Load the converted image using OpenCV
image = cv2.imread(converted_image_path)

# Calculate the average color of the image
average_color = np.mean(image, axis=(0, 1)).astype(int)

# Create a 300x300 numpy array filled with the average color
color_image = np.full((300, 300, 3), average_color, dtype=np.uint8)

# Create a PIL image from the numpy array
pil_image = Image.fromarray(color_image)

# Save the PIL image as a PNG file
output_image_path = "/Users/panagiotis/Coder/AssistedLiving/Image Dancer/hello.png"
pil_image.save(output_image_path)

# Print the average color values
print("Average Color: R={}, G={}, B={}".format(*average_color))
