require 'tty-table'
require 'tty-spinner'
require 'tty-box'
require 'tty-prompt'
pastel = Pastel.new


prompt.select('Which environment do you want to deploy to?') do |menu|
  menu.enum '.'

  menu.choice visuals.staging, 1
  menu.choice visuals.production, 2
end


->() do
  prompt.say visuals.warning_box("Your changes #{pastel.bright_red.bold('WERE NOT')} deployed to #{visuals.staging} yet")

  prompt.select("Are you sure you want to deploy to #{pastel.bright_red('production')}?") do |menu|
    menu.enum '.'

    menu.choice "No, deploy to #{visuals.staging} first", 1
    menu.choice "Yes, deploy to #{pastel.bright_red('production')} #{pastel.green('anyway')}" + pastel.dim("(хуяк-хуяк и в продакшин)"), 2
    menu.choice "Cancel safely", 3
  end
end.()





puts TTY::Box.error('You have made a mistake')



TTY::Table.new(
  ['Classic', 'New age', 'Language'],
  [
    ['cd ', 'z', 'Rust'],
    ['grep', 'rg', 'Rust'],
    ['find', 'fd', 'Rust'],
    ['cat', 'bat', 'Rust'],
    ['mc', 'xplr', 'Rust'],
    ['ls', 'exa', 'Rust'],
    ['  ', 'fzf', 'Go']
  ]
).render(:unicode) { |renderer| renderer.border.style = :yellow }
 .then { puts _1 }




TTY::Spinner.new(pastel.green("[:spinner] Performing a long running action..."), format: :dots).run do |spinner|
  sleep 2 # Long process
  spinner.success('Done!')
end.then{}
# На статичный этот не ставь совсем
puts TTY::Box.error('You have made a mistake')



TTY::ProgressBar.new(
  'Downloading [:bar]',
  total: 50,
  complete: pastel.on_green(' '),
  incomplete: pastel.red('.')
).iterate(30.times) {  }
# На статичном скриншоте прям так и оставь статичным, даже без sleep сделай



request = pastel.yellow 'DELETE /posts/1' # fancy-narrow-this-line-out
prompt.yes? "Do you really want to #{request} ?"



# vodka coffee beer


prompt.select("Okay, I checked with them and I want to:") do |menu|
  menu.enum '.'

  menu.choice "Discard their commits and deploy my commits instead", 1
  menu.choice "Deploy my commits on top of their commits " + pastel.dim("(you will be able to choose which commits to pick)"), 2
  menu.choice "Abort my deployment for now and come back later", 3
end



context 'when I create an account' do
  before { post '/accounts', account_data }

  # inspect...

  context 'when I add an item to my account' do
    before { post "/acconts/#{account.id}/items", item_data }

    # inspect...

    context 'when I delete that item' do
      before { delete "/items/#{item.id}" }

      # inspect...
    end
  end
end


  downloader_thread = Thread.new do
    until download.done?
      progress_bar.position = download.percent
    end

    puts "✓ Download complete!"
  end
  # Execution switches between the block
  # and the main code uncontrollably


  downloader_fiber = Fiber.new do
    until download.done?
      Fiber.yield  # <==== Manually defined point
                   # where the block gives up
                   # execution to the main code
      progress_bar.position = download.percent
    end

    puts "✓ Download complete!"
  end

  OBSERVED_READING_METHODS = %i[
                               getc gets read readchar readline
                               readlines wait_readable
                             ].freeze

  OBSERVED_READING_METHODS.each do |reading_method|
    stdin_reader.define_singleton_method(reading_method) do |*args|
      Fiber.yield unless ready?
      super(*args)
    end
  end



it 'asks if the user wants to order food' do
  expect(app.output)
    .to eq('Do you want to order food? (Y/n)')
end

context 'when user says "No"' do
  before { app.input.print 'n' }

  it 'says something polite' do
    expect(app.output)
      .to eq 'Okay, maybe next time'
  end

  it 'exits' do
    expect(app).to be_exited
  end
end

context 'when user says "Yes"' do
  before { app.input.print 'y' }

  it 'asks what user would like to order' do
    expect(app.output)
      .to end_with <<~OUT

      Great! What would you like?
        ‣ 1. Kebab
          2. Burger
          3. Battered chicken

    OUT
  end

  context 'when user selects something' do
    before { app.input.print '1' }

    it 'confirms the choice' do
      expect(app.output)
        .to include 'Your kebab is on its way to you'
    end

    it 'exits' do
      expect(app).to be_exited
    end
  end
end


# -----------

class VisualIdioms
        def initialize(stdin:, stdout:)
          self.stdin = stdin
          self.stdout = stdout
        end

        def info_box(message)
          TTY::Box.frame(message, border: :thick, style: { border: { fg: :bright_blue, bg: :black } }, align: :center, padding: 1)
        end

        def warning_box(message)
          TTY::Box.frame(message, border: :thick, style: { border: { fg: :bright_yellow, bg: :black } }, align: :center, padding: 1)
        end

        def error_box(message)
          TTY::Box.error(message, padding: 1)
        end

        def success_box(message)
          TTY::Box.success(message, padding: 1)
        end

        def command_execution_error_box(command, output_log)
          TTY::Box.frame(output_log, padding: 1, border: :thick, title: {bottom_left: " ✖ #{command} "}, style: { border: { fg: :red, bg: :black } })
        end

        def staging
          pastel.bright_cyan('staging')
        end

        def production
          pastel.bright_red('PRODUCTION')
        end

        def pastel
          @pastel ||= Pastel.new
        end

        def prompt
          @prompt ||= TTY::Prompt.new(help_color: :dim, symbols: { radio_off: "[ ]", radio_on: "[✓]" }, input: stdin, output: stdout)
        end

        protected

        attr_accessor :stdin, :stdout
end

def run(command_line, workdir)
  output, _process_status = Open3.capture2e command_line, chdir: workdir
  output
end



def run_git_cmd(git_cmd)
  run "git " + git_cmd, '/home/daniel/src/self-help-service'
end

def git_pretty_log
  run_git_cmd 'log --color=always --pretty="%C(Yellow)%h  %C(red)%cd %C(reset)(%C(Green)%cr%C(reset)) %C(auto)%d %C(cyan)%an: %C(reset)%s" --date=format-local:" %a %d %b %H:%M" -10'
end

def git_commit_hashes
  run_git_cmd("log --pretty='%h' -10").split("\n")
end

visial_idioms = VisualIdioms.new stdin: STDIN, stdout: STDOUT

visuals = visual_idioms
pastel = visuals.pastel
prompt = visuals.prompt

prompt.say visuals.warning_box("Your changes #{pastel.bright_red.bold('WERE NOT')} deployed to #{visuals.staging} yet.\nAre you sure you want to deploy to #{pastel.bright_red('production')}?")

commits = git_pretty_log.split("\n")
hashes = git_commit_hashes

to_be_cherry_picked_commit_shas = prompt.multi_select("\nPlease choose which commits you want to deploy\n" + pastel.bold.bright_white("Press Space to select and Enter to finish"), per_page: 20, echo: false) do |menu|
  menu.default(*(1..hashes.size).to_a) # pre-select all

  commits.zip(hashes).each do |choice, value|
    menu.choice choice, value
  end
end


prompt.say visuals.success_box("Your changes were deployed successfully")
