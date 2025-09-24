import { exec } from 'child_process';
import { platform } from 'os';
import { join } from 'path';
import { readdirSync } from 'fs';

export const SOUNDS_DIR = '/Users/nan/.claude/sounds';

export function playSound(file: string) {
  if (!file) return;
  
  const os = platform();
  let command: string;
  
  if (os === 'darwin') {
    command = `afplay "${file}"`;
  } else if (os === 'linux') {
    command = `paplay "${file}" || aplay "${file}"`;
  } else if (os === 'win32') {
    command = `powershell -c "(New-Object Media.SoundPlayer '${file}').PlaySync()"`;
  } else {
    console.error('Unsupported platform:', os);
    return;
  }
  
  exec(command, (error) => {
    if (error) {
      console.error('Failed to play sound:', error);
    }
  });
}

export function getRandomSound(soundNames?: string[]): string {
  let sounds: string[];
  
  if (soundNames && soundNames.length > 0) {
    sounds = soundNames.map(name => join(SOUNDS_DIR, name));
  } else {
    sounds = readdirSync(SOUNDS_DIR)
      .filter(file => file.endsWith('.mp3'))
      .map(file => join(SOUNDS_DIR, file));
  }
  
  if (sounds.length === 0) {
    console.error('No sound files found');
    return '';
  }
  
  return sounds[Math.floor(Math.random() * sounds.length)];
}
