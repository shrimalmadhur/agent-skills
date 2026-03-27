REPO_DIR := $(shell git rev-parse --show-toplevel)
CLAUDE_SKILLS_DIR := $(HOME)/.claude/skills
CODEX_SKILLS_DIR := $(HOME)/.codex/skills
SYNC_CODEX_SCRIPT := $(REPO_DIR)/scripts/sync_codex_skills.sh

# Discover skills from the repo so only valid skill directories are managed.
SKILL_NAMES := $(sort $(notdir $(patsubst %/SKILL.md,%,$(wildcard $(REPO_DIR)/skills/*/SKILL.md))))

.PHONY: link unlink status sync-codex-skills

# Create symlinks from ~/.claude/skills/ to this repo
link:
	@for skill in $(SKILL_NAMES); do \
		mkdir -p $(CLAUDE_SKILLS_DIR)/$$skill; \
		rm -f $(CLAUDE_SKILLS_DIR)/$$skill/SKILL.md; \
		ln -s $(REPO_DIR)/skills/$$skill/SKILL.md $(CLAUDE_SKILLS_DIR)/$$skill/SKILL.md; \
		echo "linked $$skill -> $(REPO_DIR)/skills/$$skill/SKILL.md"; \
	done

# Remove symlinks
unlink:
	@for skill in $(SKILL_NAMES); do \
		rm -f $(CLAUDE_SKILLS_DIR)/$$skill/SKILL.md; \
		echo "unlinked $$skill"; \
	done

# Copy real skill files into ~/.codex/skills for Codex discovery.
sync-codex-skills:
	@bash $(SYNC_CODEX_SCRIPT) $(REPO_DIR)/skills $(CODEX_SKILLS_DIR)

# Show current Claude symlink status and Codex sync status.
status:
	@for skill in $(SKILL_NAMES); do \
		echo "$$skill:"; \
		ls -la $(CLAUDE_SKILLS_DIR)/$$skill/SKILL.md 2>/dev/null || echo "  Claude: not linked"; \
		test -f $(CODEX_SKILLS_DIR)/$$skill/SKILL.md && echo "  Codex: present at $(CODEX_SKILLS_DIR)/$$skill/SKILL.md" || echo "  Codex: not synced"; \
	done
