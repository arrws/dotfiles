#!/usr/bin/env tsx
import { playSound, SOUNDS_DIR } from './sound-player';
import { join } from 'path';

const hookType = process.argv[2];

const soundMap: Record<string, string> = {
  // 'SessionStart': 'lol-first-blood.mp3',
  // 'SessionEnd': 'lol-defeat.mp3',
  'UserPromptSubmit': 'orc-can-do-that.mp3',
  'PreToolUse': 'orc-work-work.mp3',
  'PostToolUse': 'orc-work-work.mp3',
  'Notification': 'orc-ready-to-work.mp3',
  'Stop': 'orc-work-complete.mp3',
  'SubagentStop': 'orc-okay.mp3',
  'PreCompact': 'orc-need-more-gold.mp3'
};

if (hookType && soundMap[hookType]) {
  playSound(join(SOUNDS_DIR, soundMap[hookType]));
}
