def print_usage
  STDERR.puts "usage: bf-to-ooms [-e expression] [file path]"
  exit 1
end

brainfuck_program = String.new

case ARGV.size
when 1
  begin
    File.open(ARGV[0], "r") do |brainfuck_program_file|
      brainfuck_program = brainfuck_program_file.gets_to_end
    end
  rescue exception : File::NotFoundError
    STDERR.puts "File not found: #{exception.message}"
    exit 1
  rescue exception
    STDERR.puts "Error opening file: #{exception.message}"
    exit 1
  end
when 2
  print_usage unless ARGV[0] == "-e"
  brainfuck_program = ARGV[1]
else
  print_usage
end

brainfuck_ooms_equivalency = {'>' => "super", '<' => "super!", '+' => "ouai", '-' => "ouai,", '.' => "ouai!", ',' => "miaou!", '[' => "miaou", ']' => "miaou,"}
STDOUT.sync = true if STDOUT.tty?

brainfuck_program.each_char do |current_char|
  print "#{brainfuck_ooms_equivalency[current_char]} " if brainfuck_ooms_equivalency.has_key? current_char
end

print '\n'

exit