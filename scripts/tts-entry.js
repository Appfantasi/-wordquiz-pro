
import { Capacitor } from '@capacitor/core';
import { TextToSpeech } from '@capacitor-community/text-to-speech';

window.WordQuizTTS = {
  get isNative() {
    return Capacitor.isNativePlatform();
  },

  async speak(text, lang = 'en-GB') {
    if (!Capacitor.isNativePlatform()) {
      throw new Error('TTS nativo disponibile soltanto su Android.');
    }

    await TextToSpeech.speak({
      text: String(text || ''),
      lang,
      rate: 0.95,
      pitch: 1.0,
      volume: 1.0
    });
  },

  async stop() {
    await TextToSpeech.stop();
  }
};
