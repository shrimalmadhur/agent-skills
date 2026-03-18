REPO_DIR := $(shell git rev-parse --show-toplevel)
SKILLS_DIR := $(HOME)/.claude/skills

# Skills to link (add new skill names here)
SKILL_NAMES := adversarial-review verified-planning explain-code qa-test-writer

.PHONY: link unlink status

# Create symlinks from ~/.claude/skills/ to this repo
link:
	@for skill in $(SKILL_NAMES); do \
		mkdir -p $(SKILLS_DIR)/$$skill; \
		rm -f $(SKILLS_DIR)/$$skill/SKILL.md; \
		ln -s $(REPO_DIR)/skills/$$skill/SKILL.md $(SKILLS_DIR)/$$skill/SKILL.md; \
		echo "linked $$skill -> $(REPO_DIR)/skills/$$skill/SKILL.md"; \
	done

# Remove symlinks
unlink:
	@for skill in $(SKILL_NAMES); do \
		rm -f $(SKILLS_DIR)/$$skill/SKILL.md; \
		echo "unlinked $$skill"; \
	done

# Show current symlink status
status:
	@for skill in $(SKILL_NAMES); do \
		echo "$$skill:"; \
		ls -la $(SKILLS_DIR)/$$skill/SKILL.md 2>/dev/null || echo "  not linked"; \
	done
