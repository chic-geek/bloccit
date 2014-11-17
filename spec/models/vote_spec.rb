describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        expect(v).to eq(1)
        expect(v2).to eq(-1)
      end
    end
  end
end
