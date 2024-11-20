![image](https://github.com/user-attachments/assets/e76c8bb0-ba2a-4890-8288-cd5bedccb1e4)

# **Sine Noise Removal Using Magnitude Filter**

This MATLAB script demonstrates the process of removing sinusoidal noise from an image using a magnitude-based frequency domain filter. The workflow includes adding artificial noise, applying a filter in the Fourier domain, and visualizing the results in both 2D and 3D.

---

## **Description**
This code performs the following steps:
1. **Image Input:**
   - Loads the "Lena" image (`lena 256x256.tif`).
2. **Fourier Transform:**
   - Computes the 2D Fourier Transform of the image to analyze it in the frequency domain.
3. **Noise Addition:**
   - Adds sinusoidal noise to the image with adjustable amplitude.
4. **Noise Filtering:**
   - Removes high-magnitude frequencies using a custom threshold defined by \( \exp(15) - 1 \).
5. **Inverse Transform:**
   - Reconstructs the image using the inverse Fourier Transform after applying the filter.
6. **Visualization:**
   - Displays the original image, noisy image, filtered image, and their respective frequency spectra in 2D and 3D.

---

## **Key Features**
1. **Customizable Noise:**
   - Sinusoidal noise with configurable frequency and amplitude.
2. **Magnitude-Based Filtering:**
   - A threshold defined as \( \exp(15) - 1 \) removes unwanted high-intensity frequencies.
3. **Comprehensive Visualization:**
   - Includes 2D and 3D plots of the original spectrum, noisy spectrum, and filtered spectrum.
4. **Dynamic Masking:**
   - A logical mask is applied to the frequency spectrum to selectively remove noise.

---

## **How to Use**
1. Place the image file `lena 256x256.tif` in the same directory as the script.
2. Run the script in MATLAB.
3. Outputs:
   - A 2D visualization of the original, noisy, and filtered images.
   - Frequency spectra of all stages in both 2D and 3D.

---

## **Code Breakdown**
### **Input Image**
- The grayscale image is read and converted to double for mathematical operations.
```matlab
Read = imread('lena 256x256.tif');
f = double(Read);
```

### **Adding Noise**
- Sinusoidal noise is generated and added to the original image:
```matlab
R(J, I) = 100 * sin((2 * pi * fre) * I);
fn = f + R;
```

### **Filtering in the Fourier Domain**
1. The Fourier Transform is computed:
   ```matlab
   F2 = fft2(fn);
   F_centralizado2 = fftshift(F2);
   ```
2. A magnitude threshold is applied:
   ```matlab
   limite = exp(15) - 1;
   mascara = F_magnitude < limite;
   F_filtrado = F_centralizado2 .* mascara;
   ```

### **Inverse Transform**
- The filtered spectrum is transformed back to the spatial domain:
```matlab
F_filtrado_shifted = ifftshift(F_filtrado);
imagem_filtrada = real(ifft2(F_filtrado_shifted));
```

### **Visualization**
- The script generates:
  - **2D Plots:** Original image, noisy image, filtered image, and their spectra.
  - **3D Plots:** Frequency spectra of the original, noisy, and filtered images.
```matlab
surf(X, Y, espectro_log, 'EdgeColor', 'none');
```

---

## **Output Example**
### **2D Plots:**
1. Original Image
2. Image with Noise
3. Filtered Image
4. Frequency Spectra (Logarithmic Scale)

### **3D Plots:**
1. Original Spectrum
2. Noisy Spectrum
3. Filtered Spectrum

---

## **Adjustable Parameters**
1. **Noise Amplitude:**
   - Change the value in:
     ```matlab
     R(J, I) = 100 * sin((2 * pi * fre) * I);
     ```
2. **Filter Threshold:**
   - Modify the exponential magnitude filter:
     ```matlab
     limite = exp(15) - 1;
     ```

---

## **Applications**
- Noise removal in digital images.
- Frequency domain analysis and filtering.
- Visualization of Fourier Transform properties.
