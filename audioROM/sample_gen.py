
#pip install pydub numpy

# For Ubuntu:
#sudo apt install ffmpeg

# For MacOS:
#brew install ffmpeg


from pydub import AudioSegment
import numpy as np

def mp3_to_8bit_samples(mp3_file, output_file=None):
    # Load the MP3 file
    audio = AudioSegment.from_mp3(mp3_file)

    # Ensure the sample rate is 44.1 kHz (44100 Hz)
    audio = audio.set_frame_rate(44100)

    # Export raw audio data
    samples = np.array(audio.get_array_of_samples())

    # Convert to 8-bit (values ranging from -128 to 127)
    samples_8bit = ((samples / 256).astype(np.int8))

    # Save to a file if output filename is provided
    if output_file:
        with open(output_file, "wb") as f:
            samples_8bit.tofile(f)

    return samples_8bit


def visualize_samples(samples, sample_rate=44100, title="Audio Waveform"):
    # Create time axis in seconds based on sample rate
    time_axis = np.linspace(0, len(samples) / sample_rate, num=len(samples))

    # Plot the waveform
    plt.figure(figsize=(12, 6))
    plt.plot(time_axis, samples, color='blue')
    plt.title(title)
    plt.xlabel("Time (seconds)")
    plt.ylabel("Amplitude")
    plt.grid(True)
    plt.show()

# Example usage:
mp3_file_path = "input.mp3"
output_file_path = "output_8bit.raw"
samples_8bit = mp3_to_8bit_samples(mp3_file_path, output_file_path)

print(f"First 10 samples (8-bit): {samples_8bit[:10]}")


# Visualize the first 2 seconds of samples
visualize_samples(samples_8bit[:2 * 44100], title="8-bit Audio Waveform (First 2 seconds)")
