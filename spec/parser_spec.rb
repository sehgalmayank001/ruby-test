require 'spec_helper'
require 'log_parser'
require 'matrix'
require 'byebug'

describe LogParser do
  let(:filename)  { 'webserver.log' }

  context 'invalid filename' do
    let(:filename) { 'abc.log' }
    it 'should raise LogParser::NofileFound exception' do
      expect { LogParser.new(filename) }.to raise_error(NofileFound, "No such file exists: #{filename}")
    end
  end

  context 'valid file' do
    subject {
      described_class.new(filename)
    }

    context 'private methods' do
      describe 'readfile: ' do
        it 'should raise LogParser::NofileFound exception' do
          expect( subject.send(:readfile, filename) ).to be_an_instance_of(Array)
        end
      end

      describe 'sort_desc: ' do
      
        it 'should sort in descending order based on field ' do
          expect( subject.send(:sort_desc, 'count') ).to be_an_instance_of(Array)
          expect( Matrix[ *subject.send(:sort_desc, 'count') ].column(1).to_a.map(&:count) ).to be_sorted_array
        end
      end

      describe 'memonize' do
        it 'should create a hash for reference' do
          expect( subject.send(:memonize) ).to be_an_instance_of(Hash)
        end
      end
    end

    context 'public methods' do

      describe 'print_popular' do
        let(:response) {
          "/about/2 90 visits\n/contact 89 visits\n/index 82 visits\n/about 81 visits\n/help_page/1 80 visits\n/home 78 visits\n"
        }
        it 'should create a hash for reference' do
          expect{ subject.print_popular }.to output(response).to_stdout_from_any_process
        end
      end

      describe 'print_unique' do
        let(:response) {
          "/help_page/1 23 unique visits\n/contact 23 unique visits\n/home 23 unique visits\n/index 23 unique visits\n/about/2 22 unique visits\n/about 21 unique visits\n"
        }
        it 'should create a hash for reference' do
          expect{ subject.print_unique }.to output(response).to_stdout
        end
      end
    end

  end
end
