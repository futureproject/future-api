Sequel.migration do
  up do
    create_table :framesets do
      primary_key :id
      text :frame_1
      text :frame_2
      text :frame_3
      text :frame_4
      text :frame_5
    end
  end
end
