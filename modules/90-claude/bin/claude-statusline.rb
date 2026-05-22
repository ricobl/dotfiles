#!/usr/bin/env ruby
# frozen_string_literal: true

# Claude Code status line: RGB gradient, dynamic emoji, cost, code velocity

require 'json'
require 'shellwords'

input = $stdin.read
data = begin
  JSON.parse(input)
rescue JSON::ParserError
  {}
end

# ── ANSI helpers ──
def rgb(red, grn, blu)
  "\033[38;2;#{red};#{grn};#{blu}m"
end

CYAN    = "\033[1;36m"
GREEN   = "\033[32m"
YELLOW  = "\033[33m"
RED     = "\033[31m"
MAGENTA = "\033[1;35m"
BLUE    = "\033[1;34m"
BOLD    = "\033[1m"
RESET   = "\033[0m"
DIM     = rgb(60, 60, 60)


# ── Parse fields ──
model   = data.dig('model', 'display_name') || 'Unknown'
effort  = data.dig('effort', 'level')       || 'Unknown'
used    = data.dig('context_window', 'used_percentage')
cwd     = data.dig('workspace', 'current_dir') || data['cwd'] || ''
used_5h = (data.dig('rate_limits', 'five_hour', 'used_percentage') || 0).round
used_7d = (data.dig('rate_limits', 'seven_day', 'used_percentage') || 0).round

# ── Git info ──
branch = ''
repo   = ''
unless cwd.empty?
  branch   = `git -C #{cwd.shellescape} --no-optional-locks symbolic-ref --short HEAD 2>/dev/null`.chomp
  toplevel = `git -C #{cwd.shellescape} --no-optional-locks rev-parse --show-toplevel 2>/dev/null`.chomp
  repo     = File.basename(toplevel) unless toplevel.empty?
end

# ── Context bar ──
BAR_WIDTH = 20

def bar_color_at(pos)
  # Maps bar position (0–100) to an RGB color along a green -> yellow -> red gradient
  if pos <= 50
    t = pos / 50.0
    rgb(blend(0, 220, t), 200, blend(80, 0, t))
  else
    t = (pos - 50) / 50.0
    rgb(220, blend(200, 40, t), blend(0, 20, t))
  end
end

def blend(from, to, pct)
  (from + (to - from) * pct).round
end

def ctx_emoji(pct)
  case pct
  when 90.. then '🚨'
  when 70.. then '🔥'
  when 20.. then '⚡'
  else '🟢'
  end
end

def pct_ansi(pct)
  case pct
  when 90.. then RED
  when 70.. then YELLOW
  else GREEN
  end
end

def build_bar(used_int)
  filled = (used_int * BAR_WIDTH + 50) / 100
  (0...BAR_WIDTH).map do |i|
    pos = i * 100 / (BAR_WIDTH - 1)
    i < filled ? "#{bar_color_at(pos)}█" : "#{DIM}░"
  end.join + RESET
end

def context_bar(used)
  return "🟢 #{DIM}#{'░' * BAR_WIDTH}#{RESET} --%" unless used

  used_int = used.round
  "#{ctx_emoji(used_int)}#{build_bar(used_int)} #{pct_ansi(used_int)}#{used_int}%#{RESET}"
end

ctx_part = context_bar(used)

# ── Assemble output ──
branch_part = branch.empty? ? '' : "#{BOLD}#{GREEN} #{branch}#{RESET}"
repo_part   = repo.empty?   ? '' : "#{YELLOW}[#{BOLD}#{repo}#{branch_part}#{YELLOW}]#{RESET}"

out = "🧠 #{repo_part}#{repo_part.empty? ? '' : ' '}#{ctx_part}"
out += " #{CYAN}⏱️ #{used_5h}%#{RESET}"
out += " #{CYAN}📆 #{used_7d}%#{RESET}"
out += " #{BLUE}🤖 #{model}#{RESET}"
out += " #{MAGENTA}💪 #{effort}#{RESET}"

print out
