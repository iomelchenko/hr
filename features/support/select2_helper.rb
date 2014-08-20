module Select2Helper
  def select2(value, attrs)
    first("#s2id_#{attrs[:from]}").click
    find(".select2-input").set(value)
    within ".select2-result" do
      find("span", text: value).click
    end
  end
end

World(Select2Helper)