require 'tty-table'
require 'tty-spinner'
require 'tty-box'
require 'tty-prompt'

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


pastel = Pastel.new
TTY::Spinner.new(pastel.green("[:spinner] Performing a long running action..."), format: :dots).run do |spinner|
  sleep 2 # Long process
  spinner.success('Done!')
end.then{}





TTY::ProgressBar.new(
  'Downloading [:bar]',
  total: 50,
  complete: pastel.on_green(' '),
  incomplete: pastel.red('.')
).iterate(50.times) { sleep(0.05) }



request = pastel.yellow 'DELETE /posts/1' # fancy-narrow-this-line-out
prompt.yes? "Do you really want to #{request} ?"



# vodka coffee beer


prompt.select("Okay, I checked with them and I want to:") do |menu|
  menu.enum '.'

  menu.choice "Discard their commits and deploy my commits instead", 1
  menu.choice "Deploy my commits on top of their commits " + pastel.dim("(you will be able to choose which commits to pick)"), 2
  menu.choice "Abort my deployment for now and come back later", 3
end
