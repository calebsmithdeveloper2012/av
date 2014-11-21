module Av
  class Cli
    attr_accessor :command
    
    def initialize(options)
      found = []
      found << 'ffmpeg' if self.detect_command('ffmpeg')
      if found.empty?
        raise Av::UnableToDetect, "Unable to detect any supported library"
      else
        @command = Object.const_get('Av').const_get('Commands').const_get(found.first.capitalize).new(options)
      end
      ::Av.log("Found #{found.inspect}, using: #{found.first.capitalize}")
      puts "Test"
    end
    
    protected
      def method_missing name, *args, &block
        @command.send(name, *args, &block)
      end
  
      def detect_command(command)
        command = "ffmpeg"
        result = ::Av.run(command)
      end
  end
end