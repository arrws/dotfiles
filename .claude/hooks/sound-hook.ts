#!/usr/bin/env tsx
import { playSound, SOUNDS_DIR } from './sound-player';
import { join } from 'path';

const hookType = process.argv[2];

const soundMap: Record<string, string> = {
  // 'SessionStart': 'ready-to-work.mp3',
  // 'SessionEnd': 'lol-defeat.mp3',
  'UserPromptSubmit': 'be-happy-to.mp3',
  'PreToolUse': 'work-work.mp3',
  'PostToolUse': 'work-work.mp3',
  'Notification': 'ready-to-work.mp3',
  'Stop': 'yes.mp3',
  'SubagentStop': 'anime-wow.mp3',
  'PreCompact': 'we-need-more-gold.mp3'
};

if (hookType && soundMap[hookType]) {
  playSound(join(SOUNDS_DIR, soundMap[hookType]));
}
