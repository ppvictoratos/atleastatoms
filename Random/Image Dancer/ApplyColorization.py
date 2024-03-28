import cv2
import numpy as np

# Define the path to the directory containing the JPEG images
image_directory = "/Users/panagiotis/Desktop/zawrudo"

def apply_colorization(image_path):
    # Load the image
    image = cv2.imread(image_path)
    
    # Convert the image to the HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    
    # Modify the hue component while keeping the brightness constant
    modified_hsv_image = np.copy(hsv_image)
    modified_hsv_image[..., 0] = (modified_hsv_image[..., 0] + 45) % 180  # Change the hue by adding 45 degrees
    
    # Convert the modified image back to the BGR color space
    colorized_image = cv2.cvtColor(modified_hsv_image, cv2.COLOR_HSV2BGR)
    
    # Display or save the colorized image
    cv2.imshow("Colorized Image", colorized_image)
    cv2.waitKey(0)  # Wait for a key press before moving to the next image
    cv2.destroyAllWindows()

# Iterate over the JPEG images in the directory
for filename in os.listdir(image_directory):
    if filename.endswith(".jpg") or filename.endswith(".jpeg"):
        image_path = os.path.join(image_directory, filename)
        apply_colorization(image_path)
