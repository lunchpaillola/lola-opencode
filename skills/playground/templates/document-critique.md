# Document Critique Template

Use this template when the playground helps review and critique documents: SKILL.md files, READMEs, specs, proposals, or any text that needs structured feedback with approve/reject/comment workflow.

## Layout

```
+---------------------------+--------------------+
|                           |  [Suggestions] [Add|
|  Document content         |   Comments (3)]    |
|  with line numbers        |                    |
|  and suggestion           +--------------------+
|  highlighting             |  Suggestions Tab:  |
|                           |  • Filter tabs     |
|  Click any line to        |  • Stats           |
|  auto-switch to           |  • Suggestion list |
|  Comments tab             |    with Approve/   |
|                           |    Reject/Reset    |
+---------------------------+--------------------+
|  Comments Tab:            |
|  • Context header (line   |
|    number + content)      |
|  • Jump to line button    |
|  • Comment input          |
|  • Save/Clear buttons     |
|  • Your Comments list     |
+---------------------------+--------------------+
|  Prompt output (approved + commented items)    |
|  [ Copy Prompt ]                               |
+------------------------------------------------+
```

## Key components

### Document panel (left)
- Display full document with line numbers
- Highlight lines with suggestions using a colored left border
- Color-code by status: pending (amber), approved (green), rejected (red with opacity)
- **Click any line** to auto-switch to the Comments tab and add a contextual comment
- Lines with user comments get a right-side accent border and asterisk indicator
- Selected lines highlighted with dashed border

### Sidebar tabs (right)
Two tabs at the top of the right panel:

#### 1. Suggestions Tab
- Filter tabs: All / Pending / Approved / Rejected
- Stats in header showing counts for each status
- Each suggestion card shows:
  - Line reference (e.g., "Line 3" or "Lines 17-24")
  - The suggestion text
  - Action buttons: Approve / Reject / Comment (or Reset if already decided)
  - Optional textarea for user comments

#### 2. Add Comments Tab
Always available for adding free-form comments to any line:

- **Context header**: Shows selected line number and actual line content
- **Jump to line** button: Scrolls document to the selected line
- **Comment input**: Textarea for writing the comment
- **Save Comment** button: Saves the comment with visual feedback
- **Clear** button: Removes the comment for the selected line
- **Your Comments** section: Lists all comments with Go/Remove actions
- **Badge**: Shows count of user comments on the tab

## State structure

```javascript
const suggestions = [
  {
    id: 1,
    lineRef: "Line 3",
    targetText: "description: Creates interactive...",
    suggestion: "The description is too long. Consider shortening.",
    category: "clarity",  // clarity, completeness, performance, accessibility, ux
    status: "pending",    // pending, approved, rejected
    userComment: ""
  },
  // ... more suggestions
];

let state = {
  suggestions: [...],
  activeFilter: "all",
  activeSuggestionId: null,
  activeTab: "suggestions",  // "suggestions" | "comments"
  activeLineNumber: null,    // for comment context
  lineComments: {}           // { lineNumber: "comment text" }
};
```

## Tab switching

```javascript
function switchTab(tabName) {
  state.activeTab = tabName;
  
  document.querySelectorAll('.sidebar-tab').forEach(tab => {
    tab.classList.toggle('active', tab.dataset.tab === tabName);
  });
  
  document.getElementById('suggestionsTab').classList.toggle('hidden', tabName !== 'suggestions');
  document.getElementById('commentsTab').classList.toggle('hidden', tabName !== 'comments');
}

// Auto-switch when clicking document lines
docLinesEl.addEventListener("click", event => {
  const lineEl = event.target.closest(".doc-line");
  if (!lineEl) return;
  const lineNumber = Number(lineEl.dataset.line);
  if (!lineNumber) return;
  state.activeLineNumber = lineNumber;
  
  if (state.activeTab !== 'comments') {
    switchTab('comments');
  }
  
  syncCommentEditor();
  renderDocument();
  renderCommentList();
});
```

## Comment editor sync

```javascript
function syncCommentEditor() {
  if (state.activeLineNumber) {
    const lineContent = docLines[state.activeLineNumber - 1] || "";
    contextLine.textContent = `Line ${state.activeLineNumber}`;
    contextLine.classList.add("has-selection");
    contextPreview.textContent = lineContent || "(empty line)";
    jumpToLineBtn.disabled = false;
    
    lineCommentInput.disabled = false;
    saveCommentBtn.disabled = false;
    clearCommentButton.disabled = false;
    lineCommentInput.value = state.lineComments[state.activeLineNumber] || "";
  } else {
    contextLine.textContent = "Click any line in the document to add a comment";
    contextLine.classList.remove("has-selection");
    contextPreview.textContent = "Select a line to see its content here";
    jumpToLineBtn.disabled = true;
    
    lineCommentInput.value = "";
    lineCommentInput.disabled = true;
    saveCommentBtn.disabled = true;
    clearCommentButton.disabled = true;
  }
}
```

## CSS for comments system

```css
/* Tab navigation */
.sidebar-tabs {
  display: flex;
  border-bottom: 1px solid var(--line);
  background: var(--panel-2);
}

.sidebar-tab {
  flex: 1;
  padding: 12px 16px;
  background: transparent;
  border: none;
  color: var(--muted);
  font-size: 13px;
  cursor: pointer;
  position: relative;
}

.sidebar-tab.active {
  color: var(--accent);
  background: var(--panel);
}

.sidebar-tab.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: var(--accent);
}

.tab-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 18px;
  height: 18px;
  padding: 0 5px;
  background: var(--accent);
  color: var(--bg);
  font-size: 11px;
  font-weight: 600;
  border-radius: 9px;
  margin-left: 6px;
}

/* Line indicators */
.doc-line.has-comment {
  border-right: 3px solid rgba(86, 197, 182, 0.6);
}

.doc-line.has-comment .line-number::after {
  content: "*";
  margin-left: 4px;
  color: var(--accent);
}

.doc-line.selected {
  outline: 1px dashed rgba(226, 183, 106, 0.6);
}

/* Comment context box */
.comment-context {
  background: var(--panel-2);
  border: 1px solid var(--line);
  border-radius: 10px;
  overflow: hidden;
  margin-bottom: 12px;
}

.context-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 12px;
  background: rgba(86, 197, 182, 0.08);
  border-bottom: 1px solid var(--line);
  font-size: 12px;
}

.context-preview {
  padding: 12px;
  font-family: ui-monospace, monospace;
  font-size: 12px;
  max-height: 80px;
  overflow: auto;
  white-space: pre-wrap;
}

/* Comment cards */
.comment-card {
  border: 1px solid var(--line);
  border-radius: 10px;
  padding: 10px;
  background: rgba(9, 13, 18, 0.6);
  cursor: pointer;
  transition: all 0.2s ease;
}

.comment-card:hover {
  border-color: rgba(86, 197, 182, 0.3);
}

.comment-card.active {
  border-color: var(--accent);
  background: rgba(86, 197, 182, 0.08);
}
```

## Suggestion matching to lines

Match suggestions to document lines by parsing the lineRef:

```javascript
const suggestion = state.suggestions.find(s => {
  const match = s.lineRef.match(/Line[s]?\s*(\d+)/);
  if (match) {
    const targetLine = parseInt(match[1]);
    return Math.abs(targetLine - lineNum) <= 2; // fuzzy match nearby lines
  }
  return false;
});
```

## Document rendering

Handle markdown-style formatting inline:

```javascript
// Skip ``` lines, wrap content in code-block-wrapper
if (line.startsWith('```')) {
  inCodeBlock = !inCodeBlock;
  // Open or close wrapper div
}

// Headers
if (line.startsWith('# ')) renderedLine = `<h1>...</h1>`;
if (line.startsWith('## ')) renderedLine = `<h2>...</h2>`;

// Inline formatting (outside code blocks)
renderedLine = renderedLine.replace(/`([^`]+)`/g, '<code>$1</code>');
renderedLine = renderedLine.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
```

## Prompt output generation

Include both suggestion comments and line comments:

```javascript
function updatePrompt() {
  const approved = state.suggestions.filter(s => s.status === 'approved');
  const withComments = state.suggestions.filter(s => s.userComment?.trim());
  const extraComments = withComments.filter(s => s.status !== 'approved');
  const lineComments = Object.entries(state.lineComments)
    .map(([line, text]) => ({ line: Number(line), text: text.trim() }))
    .filter(entry => entry.text.length > 0)
    .sort((a, b) => a.line - b.line);

  if (approved.length === 0 && withComments.length === 0 && lineComments.length === 0) {
    // Show placeholder
    return;
  }

  let prompt = 'Please update [DOCUMENT] with the following changes:\n\n';

  if (approved.length > 0) {
    prompt += '## Approved Improvements\n\n';
    for (const s of approved) {
      prompt += `**${s.lineRef}:** ${s.suggestion}`;
      if (s.userComment?.trim()) {
        prompt += `\n  → User note: ${s.userComment.trim()}`;
      }
      prompt += '\n\n';
    }
  }

  if (extraComments.length > 0) {
    prompt += '## Additional Feedback\n\n';
    for (const s of extraComments) {
      prompt += `**${s.lineRef}:** ${s.userComment.trim()}\n\n`;
    }
  }

  if (lineComments.length > 0) {
    prompt += '## Line Comments\n\n';
    for (const entry of lineComments) {
      prompt += `**Line ${entry.line}:** ${entry.text}\n\n`;
    }
  }
  
  // ... copy to clipboard
}
```

## Pre-populating suggestions

When building a critique playground for a specific document:

1. Read the document content
2. Analyze and generate suggestions with:
   - Specific line references
   - Clear, actionable suggestion text
   - Category tags (clarity, completeness, performance, accessibility, ux)
3. Embed both the document content and suggestions array in the HTML

## Example use cases

- SKILL.md review (skill definition quality, completeness, clarity)
- README critique (documentation quality, missing sections, unclear explanations)
- Spec review (requirements clarity, missing edge cases, ambiguity)
- Proposal feedback (structure, argumentation, missing context)
- Code comment review (docstring quality, inline comment usefulness)
