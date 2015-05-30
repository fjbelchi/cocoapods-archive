require 'zip'

module Pod
  class Command
    # Archive command
    class Archive < Command
      self.summary = 'Archive source code and Pods'

      self.description = <<-DESC
        Pod archive will execute a pod install, create a tag and a zip.
        It's helpful when the Pods directory isn't included in the repository
      DESC

      self.arguments = [CLAide::Argument.new('VERSION', true)]

      def initialize(argv)
        @version = argv.shift_argument
        super
      end

      def validate!
        super
        help! 'A version is required.' unless @version
      end

      def run
        perform_cocoapods_installation

        UI.titled_section 'Creating Tag' do
          system "git tag #{@version}"
          system "git push origin #{@version}"
        end

        UI.titled_section 'Creating Zip' do
          zip
        end
      end

      private

      # @return [void] Performs a CocoaPods installation in the working
      #         directory.
      #
      def perform_cocoapods_installation
        UI.titled_section 'Performing CocoaPods Installation' do
          Command::Install.invoke
        end
      end

      # @return [void] Performs a zip of the workspace directory
      #
      def zip
        entries = Dir.entries('.')
        entries.delete('.')
        entries.delete('..')
        file = "archive-#{@version}.zip"
        path = File.absolute_path(file)
        File.delete(path) if File.exist?(path)
        io = Zip::File.open(file, Zip::File::CREATE)

        write_entries(entries, '', io)
        io.close
      end

      # A helper method to make the recursion work.
      def write_entries(entries, path, io)
        entries.each do |e|
          zip_file_path = path == '' ? e : File.join(path, e)
          disk_file_path = File.join('.', zip_file_path)
          if File.directory?(disk_file_path)
            io.mkdir(zip_file_path)
            subdir = Dir.entries(disk_file_path)
            subdir.delete('.')
            subdir.delete('..')
            write_entries(subdir, zip_file_path, io)
          else
            io.get_output_stream(zip_file_path) do |f|
              f.puts(File.open(disk_file_path, 'rb').read)
            end
          end
        end
      end
    end
  end
end
