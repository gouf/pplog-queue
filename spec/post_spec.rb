require 'spec_helper'
require_relative '../yaml_record'

describe "Post" do

  before do
    remove_all_records()
  end

  describe "Record Manipulation Test" do
    subject { Post }

    def remove_all_records
      (subject.all).each(&:destroy)
    end

    context "when delete all posts" do
      it "is count as 0" do
        expect(subject.all.count).to eq 0
      end
    end

    context "when insert an record" do
      before { subject.create(body: 'foo') }

      it "is count as 1" do
        expect(subject.all.size).to eq 1
      end

      it "is body as 'foo'" do
        expect(subject.all.first.body).to eq 'foo'
      end
    end

    context "when insert two records" do
      before { %w(foo bar).each { |x| subject.create(body: x) } }

      it "is first record body as 'foo'" do
        expect(subject.all.first.body).to eq 'foo'
      end

      it "is last record body as 'bar'" do
        expect(subject.all.last.body).to eq 'bar'
      end
    end
  end

  after { remove_all_records() }
end
