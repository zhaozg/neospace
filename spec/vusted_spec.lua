describe("vusted", function()
  it("can use vim module", function()
    assert.is_nil(vim.Nil)
  end)

  it("can print", function()
    print("printed\n")
  end)
end)
