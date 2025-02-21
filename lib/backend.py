from flask import Flask, request, jsonify
import torch
from diffusers import StableDiffusionPipeline
from io import BytesIO
import base64
from PIL import Image

app = Flask(__name__)

# Load the model
pipe = StableDiffusionPipeline.from_pretrained("CompVis/stable-diffusion-v1-4", torch_dtype=torch.float16)
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
pipe = pipe.to(device)

@app.route('/generate', methods=['POST'])
def generate_image():
    data = request.json
    prompt = data.get('prompt', '')
    
    if not prompt:
        return jsonify({'error': 'No prompt provided'}), 400
    
    # Generate the image
    image = pipe(prompt).images[0]
    
    # Convert image to base64
    buffered = BytesIO()
    image.save(buffered, format="PNG")
    img_str = base64.b64encode(buffered.getvalue()).decode('utf-8')
    
    return jsonify({'image': img_str})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)