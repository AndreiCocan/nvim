-- ============================================================================
-- Motion
-- ============================================================================

-- better up/down (respect wrapped lines)
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- saner n/N — always go forward/backward and center the result
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- ============================================================================
-- Flash (jump / labelled motions)
-- ============================================================================

-- Jump anywhere on screen by typing the label that appears
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
-- Select/expand by Treesitter nodes
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
-- Operate on a remote location without moving the cursor (e.g. yri")
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
-- Treesitter search: incremental node selection from a search
vim.keymap.set({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
-- Toggle Flash while in a regular `/` or `?` search
vim.keymap.set('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })

-- ============================================================================
-- Editing
-- ============================================================================

vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = '[S]ave File' })

-- keep visual selection after indent
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- move lines
vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- ============================================================================
-- Windows
-- ============================================================================

-- navigate
vim.keymap.set('n', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Window Left' })
vim.keymap.set('n', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Window Down' })
vim.keymap.set('n', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Window Up' })
vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Window Right' })

-- resize
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Window Height +' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Window Height -' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Window Width -' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Window Width +' })

-- split / close
vim.keymap.set('n', '<leader>-', '<cmd>split<cr>', { desc = 'Window Split Below' })
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Window Split Right' })
vim.keymap.set('n', '<leader>wd', '<cmd>close<cr>', { desc = '[W]indow [D]elete' })
vim.keymap.set('n', '<leader>wm', function() Snacks.toggle.zoom():toggle() end, { desc = '[W]indow [M]aximize' })

-- close current window with C-w alone (overrides vim's window prefix)
-- Also remove the nvim 0.11 defaults <C-W>d / <C-W><C-D> so C-w fires without timeout lag
pcall(vim.keymap.del, 'n', '<C-W>d')
pcall(vim.keymap.del, 'n', '<C-W><C-D>')
vim.keymap.set('n', '<C-w>', '<cmd>close<cr>', { desc = 'Close Window' })

-- ============================================================================
-- Quit
-- ============================================================================

vim.keymap.set('n', '<leader>qQ', '<cmd>qa<cr>', { desc = '[Q]uit All' })
vim.keymap.set('n', '<leader>qq', '<cmd>wqa<cr>', { desc = '[Q]uit + [W]rite All' })

-- ============================================================================
-- Project / Session (persistence)
-- ============================================================================

vim.keymap.set('n', '<leader>pp', function() Persistence.load { last = true } end, { desc = 'Restore Last Session' })
vim.keymap.set('n', '<leader>pd', function() Persistence.stop() end, { desc = "Don't Save Current Session" })

-- ============================================================================
-- Buffers
-- ============================================================================

-- navigation (follows the visual bufferline order)
vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev [B]uffer' })
vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next [B]uffer' })
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev [B]uffer' })
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next [B]uffer' })

-- reorder buffers in the bufferline
vim.keymap.set('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move [B]uffer Left' })
vim.keymap.set('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move [B]uffer Right' })

-- pick / find a buffer
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<cr>', { desc = '[B]uffer [P]ick' })
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = '[F]ind [B]uffer' })

-- delete
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bo', function() Snacks.bufdelete.other() end, { desc = '[B]uffer Delete [O]thers' })
vim.keymap.set('n', '<leader>bi', function() Snacks.bufdelete.invisible() end, { desc = '[B]uffer Delete [I]nvisible' })

-- ============================================================================
-- Files & Explorer
-- ============================================================================

vim.keymap.set('n', '<leader>nf', '<cmd>enew<cr>', { desc = '[N]ew [F]ile' })
vim.keymap.set('n', '<leader>e', function() Snacks.explorer { cwd = Snacks.git.get_root() or vim.fn.getcwd() } end,
  { desc = '[E]xplorer' })

-- pickers
vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.smart() end, { desc = 'Smart Find Files' })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
  { desc = '[F]ind Nvim [C]onfig File' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = '[F]ind [R]ecent' })
vim.keymap.set('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = '[F]ind [P]rojects' })

-- resume last picker
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = '[S]earch [R]esume Picker' })

-- ============================================================================
-- Terminal
-- ============================================================================

-- stable git root: when inside a terminal, use the alternate buffer's file
local function project_root()
  local path
  if vim.bo.buftype == 'terminal' then
    path = vim.fn.expand '#:p'
  else
    path = vim.api.nvim_buf_get_name(0)
  end
  if path == '' then path = vim.fn.getcwd() end
  return Snacks.git.get_root(path) or vim.fn.getcwd()
end

-- toggle ALL terminals: hide if any visible, show all if hidden, open one if none exist
local function term_toggle_all()
  local terms = Snacks.terminal.list()
  local visible = {}
  for _, t in ipairs(terms) do
    if t:win_valid() then table.insert(visible, t) end
  end
  if #visible > 0 then
    for _, t in ipairs(visible) do
      t:hide()
    end
  elseif #terms > 0 then
    for _, t in ipairs(terms) do
      t:show()
    end
  else
    Snacks.terminal.toggle(nil, { cwd = project_root() })
  end
end
vim.keymap.set({ 'n', 't' }, '<C-/>', term_toggle_all, { desc = 'Terminal Toggle All' })
vim.keymap.set({ 'n', 't' }, '<C-_>', term_toggle_all, { desc = 'which_key_ignore' })

-- close the focused terminal cleanly (terminal mode only)
vim.keymap.set('t', '<C-w>', function()
  local chan = vim.bo.channel
  if chan and chan > 0 then vim.fn.chansend(chan, 'exit\n') end
end, { desc = 'Close Terminal' })

-- terminal at current file's directory
vim.keymap.set({ 'n', 't' }, '<C-A-/>', function()
  local dir
  if vim.bo.buftype == 'terminal' then
    dir = vim.fn.expand '#:p:h'
  else
    dir = vim.fn.expand '%:p:h'
  end
  if dir == '' then dir = project_root() end
  Snacks.terminal.toggle(nil, { cwd = dir })
end, { desc = 'Terminal (Current File Dir)' })

-- new terminal each press (counter ensures unique id)
local term_n = 1
vim.keymap.set({ 'n', 't' }, '<C-t>', function()
  term_n = term_n + 1
  Snacks.terminal.toggle(nil, { cwd = project_root(), count = term_n })
end, { desc = 'Terminal New' })

-- exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit Terminal Mode' })

-- window navigation from terminal mode (no <Esc> needed)
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Go to Left Window' })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Go to Lower Window' })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Go to Upper Window' })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Go to Right Window' })

-- ============================================================================
-- Search & Grep
-- ============================================================================

vim.keymap.set('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = '[S]earch [B]uffer Lines' })
vim.keymap.set('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = '[S]earch Open [B]uffers' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end,
  { desc = '[S]earch [W]ord/Selection' })

-- history
vim.keymap.set('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = '[S]earch [C]ommand History' })
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = '[S]earch History' })

-- ============================================================================
-- Discovery (commands, keymaps, help, registers, marks…)
-- ============================================================================

vim.keymap.set('n', '<leader>?', function() require('which-key').show { global = false } end,
  { desc = 'Buffer Keymaps (which-key)' })
vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[S]earch [H]elp Pages' })
vim.keymap.set('n', '<leader>sM', function() Snacks.picker.man() end, { desc = '[S]earch [M]an Pages' })
vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = '[S]earch [A]utocmds' })
vim.keymap.set('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = '[S]earch [J]umps' })
vim.keymap.set('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = '[S]earch Registers' })
vim.keymap.set('n', '<leader>sn', function() Snacks.picker.notifications() end,
  { desc = '[S]earch [N]otification History' })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = '[S]earch [H]ighlights' })
vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = '[S]earch [I]cons' })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = '[S]earch [U]ndo History' })

-- ============================================================================
-- UI (notifications, colorschemes, highlights, icons)
-- ============================================================================

vim.keymap.set('n', '<leader>uc', function() Snacks.picker.colorschemes() end, { desc = '[U]I [C]olorschemes' })
vim.keymap.set('n', '<leader>uz', function() Snacks.toggle.zen():toggle() end, { desc = '[U]I [Z]en Mode' })

-- ============================================================================
-- Git
-- ============================================================================

if vim.fn.executable 'lazygit' == 1 then
  vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit { cwd = Snacks.git.get_root() } end,
    { desc = 'Lazy[G]it (Root)' })
end

vim.keymap.set('n', '<leader>fg', function() Snacks.picker.git_files { cwd = Snacks.git.get_root() } end,
  { desc = '[F]ind [G]it Files' })
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status { cwd = Snacks.git.get_root() } end,
  { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff { cwd = Snacks.git.get_root() } end,
  { desc = '[G]it [D]iff (Hunks)' })
vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_branches { cwd = Snacks.git.get_root() } end,
  { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log { cwd = Snacks.git.get_root() } end,
  { desc = '[G]it [L]og' })
vim.keymap.set('n', '<leader>gL', function() Snacks.picker.git_log_line { cwd = Snacks.git.get_root() } end,
  { desc = '[G]it [L]og Line' })
vim.keymap.set('n', '<leader>gf', function() Snacks.picker.git_log_file { cwd = Snacks.git.get_root() } end,
  { desc = '[G]it Log [F]ile' })
vim.keymap.set('n', '<leader>gS', function() Snacks.picker.git_stash { cwd = Snacks.git.get_root() } end,
  { desc = '[G]it [S]tash' })

-- ============================================================================
-- Kubernetes
-- ============================================================================

-- k9s in a floating terminal, same as lazygit. toggle reuses the running instance.
if vim.fn.executable 'k9s' == 1 then
  vim.keymap.set('n', '<leader>k9', function() Snacks.terminal.toggle('k9s', { win = { style = 'lazygit' } }) end,
    { desc = '[K]9s' })
end

-- ============================================================================
-- Docker
-- ============================================================================

-- lazydocker in a floating terminal, same as lazygit/k9s. toggle reuses the instance.
if vim.fn.executable 'lazydocker' == 1 then
  vim.keymap.set('n', '<leader>dd', function() Snacks.terminal.toggle('lazydocker', { win = { style = 'lazygit' } }) end,
    { desc = 'Lazy[D]ocker' })
end

-- ============================================================================
-- Quickfix & Location list
-- ============================================================================

vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Prev [Q]uickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next [Q]uickfix' })

vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = '[S]earch [Q]uickfix' })
vim.keymap.set('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = '[S]earch [L]ocation List' })

-- ============================================================================
-- Diagnostics
-- ============================================================================

local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump {
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    }
  end
end

vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = '[C]ode [D]iagnostics (Line)' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next [D]iagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev [D]iagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next [E]rror' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev [E]rror' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next [W]arning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev [W]arning' })

-- pickers
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end,
  { desc = '[S]earch [D]iag (Buffer)' })

-- ============================================================================
-- Trouble (docked list panel)
-- ============================================================================

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: Diagnostics (All)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
  { desc = 'Trouble: Diagnostics (Buffer)' })
vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Trouble: Symbols' })
vim.keymap.set('n', '<leader>xr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
  { desc = 'Trouble: LSP References/Defs' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>', { desc = 'Trouble: Location List' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Trouble: Quickfix List' })

-- ============================================================================
-- LSP (buffer-local, set on attach)
-- ============================================================================

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local function map(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs,
        { buffer = args.buf, noremap = true, silent = true, desc = desc }) end

    -- navigation (snacks pickers)
    map('gd', function() Snacks.picker.lsp_definitions() end, '[G]oto [D]efinition')
    map('gD', function() Snacks.picker.lsp_declarations() end, '[G]oto [D]eclaration')
    map('gr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
    map('gI', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')
    map('gy', function() Snacks.picker.lsp_type_definitions() end, '[G]oto T[y]pe Definition')
    map('gai', function() Snacks.picker.lsp_incoming_calls() end, '[G]oto C[a]lls [I]ncoming')
    map('gao', function() Snacks.picker.lsp_outgoing_calls() end, '[G]oto C[a]lls [O]utgoing')
    map('<leader>ss', function() Snacks.picker.lsp_symbols() end, '[S]earch LSP [S]ymbols')
    map('<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, '[S]earch LSP Workspace [S]ymbols')

    -- actions
    map('K', vim.lsp.buf.hover, 'Hover')
    map('<leader>rn', vim.lsp.buf.rename, '[R]efactor [N]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('<leader>cf', function() vim.lsp.buf.format { async = true } end, '[C]ode [F]ormat')
  end,
})

-- references (snacks.words) — buffer-wide jump between occurrences
vim.keymap.set('n', ']r', function() Snacks.words.jump(vim.v.count1, true) end, { desc = 'Next [R]eference' })
vim.keymap.set('n', '[r', function() Snacks.words.jump(-vim.v.count1, true) end, { desc = 'Prev [R]eference' })

-- ============================================================================
-- Todo comments
-- ============================================================================

vim.keymap.set('n', '<leader>st', function() Snacks.picker.todo_comments() end, { desc = '[S]earch [T]odo' })
vim.keymap.set('n', '<leader>sT', function() Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } } end,
  { desc = '[S]earch [T]odo/Fix/Fixme' })
vim.keymap.set('n', ']t', function() Todo.jump_next() end, { desc = 'Next [T]odo Comment' })
vim.keymap.set('n', '[t', function() Todo.jump_prev() end, { desc = 'Prev [T]odo Comment' })

-- ============================================================================
-- Scope (snacks)
-- ============================================================================

-- Text objects: select/operate on the current scope (e.g. vii, dai, yai)
vim.keymap.set({ 'x', 'o' }, 'ii', function() Snacks.scope.textobject() end, { desc = 'inner scope' })
vim.keymap.set({ 'x', 'o' }, 'ai', function() Snacks.scope.textobject { edge = true } end, { desc = 'around scope' })

-- Jump to the top/bottom edge of the current scope
vim.keymap.set({ 'n', 'x', 'o' }, '[i', function() Snacks.scope.jump { min_size = 1 } end, { desc = 'top edge of scope' })
vim.keymap.set({ 'n', 'x', 'o' }, ']i', function() Snacks.scope.jump { min_size = 1, bottom = true } end,
  { desc = 'bottom edge of scope' })

-- ============================================================================
-- Treesitter text-objects
-- ============================================================================

-- Select: af/if = function, ac/ic = class, aa/ia = parameter
local select = function(query)
  return function() require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects') end
end
vim.keymap.set({ 'x', 'o' }, 'af', select '@function.outer', { desc = 'a function' })
vim.keymap.set({ 'x', 'o' }, 'if', select '@function.inner', { desc = 'inner function' })
vim.keymap.set({ 'x', 'o' }, 'ac', select '@class.outer', { desc = 'a class' })
vim.keymap.set({ 'x', 'o' }, 'ic', select '@class.inner', { desc = 'inner class' })
vim.keymap.set({ 'x', 'o' }, 'aa', select '@parameter.outer', { desc = 'a parameter' })
vim.keymap.set({ 'x', 'o' }, 'ia', select '@parameter.inner', { desc = 'inner parameter' })

-- Move: jump between function/class starts and ends (require is lazy — keymaps.lua loads before plugins)
local move = function(fn)
  return function() require('nvim-treesitter-textobjects.move')[fn]('@function.outer', 'textobjects') end
end
vim.keymap.set({ 'n', 'x', 'o' }, ']f', move 'goto_next_start', { desc = 'Next [F]unction Start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[f', move 'goto_previous_start', { desc = 'Prev [F]unction Start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']F', move 'goto_next_end', { desc = 'Next [F]unction End' })
vim.keymap.set({ 'n', 'x', 'o' }, '[F', move 'goto_previous_end', { desc = 'Prev [F]unction End' })

-- ============================================================================
-- Per-language Code actions (<leader>c…)
-- ============================================================================
-- Same keys across languages; only the action changes per filetype. Applied
-- buffer-local on FileType. Add a language by adding an entry to lang_code.
--   <leader>cr = Run   <leader>ct = Test nearest   <leader>cT = Test all   <leader>cb = Build
local lang_code = {
  go = {
    cr = { '<cmd>GoRun<cr>', 'Run' },
    ct = { '<cmd>GoTestFunc<cr>', 'Test (Function)' },
    cT = { '<cmd>GoTestPkg<cr>', 'Test (Package)' },
    cn = { '<cmd>GoTestFile<cr>', 'Test (File)' },
    cb = { '<cmd>GoBuild<cr>', 'Build' },
    cv = { '<cmd>GoCoverage<cr>', 'Coverage' },
    ce = { '<cmd>GoIfErr<cr>', 'Add if err' },
    cs = { '<cmd>GoFillStruct<cr>', 'Fill Struct' },
    ci = { '<cmd>GoImpl<cr>', 'Implement Interface' },
    cu = { '<cmd>GoAddTest<cr>', 'Add Unit Test' },
    cj = { '<cmd>GoAddTag<cr>', 'Add Struct Tags' },
    co = { '<cmd>GoAlt<cr>', 'Toggle Test/Impl File' },
    cm = { '<cmd>GoModTidy<cr>', 'Mod Tidy' },
  },
}

local lang_code_grp = vim.api.nvim_create_augroup('lang_code_maps', { clear = true })
for ft, maps in pairs(lang_code) do
  vim.api.nvim_create_autocmd('FileType', {
    group = lang_code_grp,
    pattern = ft,
    callback = function(ev)
      for lhs, rhs in pairs(maps) do
        vim.keymap.set('n', '<leader>' .. lhs, rhs[1], { buffer = ev.buf, silent = true, desc = rhs[2] })
      end
      -- also register with which-key (buffer-local) so the menu lists them reliably
      local ok, wk = pcall(require, 'which-key')
      if ok then
        local items = { buffer = ev.buf }
        for lhs, rhs in pairs(maps) do
          table.insert(items, { '<leader>' .. lhs, rhs[1], desc = rhs[2] })
        end
        wk.add(items)
      end
    end,
  })
end
