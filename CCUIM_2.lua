------- Configurações --------
--51px*19px
local NameTypeStorage = "sophisticatedstorage:controller" ----- Nome dos tipos de inventario de armazenamento principal
local NameResultInventoury = "minecraft:barrel_2" ------------- Nome do inventario de tramitação de saida
local NameStoreInventoury = "minecraft:barrel_4" -------------- Nome do inventario de tramitação de entrada
local IdTerminalCraftTurtle = 2 ------------------------------- Id da turtle usada para crafting no terminal
local TerminalCrafttingDeposit = "minecraft:barrel_3" --------- Inventario para a turtle
local IdCraftTurtle = 3 --------------------------------------- Id da turtle usada para crafting
local CrafttingDeposit = "minecraft:barrel_1" ----------------- Inventario para a turtle
local NameRednetModem = "modem_0" ----------------------------- Nome do modem usado para comunicação sem fio
------- Periféricos ---------
local PERIPHERALS = peripheral.getNames() --------------------------------- Lista de todos os periféricos
local STORAGES = {} ------------------------------------------------------- Lista de todos os armazéns
local REDNETCONNECTION = rednet.open(NameRednetModem) --------------------- Conecção ao rednet
local MONITORCRAFTINGSTORAGE = peripheral.wrap(TerminalCrafttingDeposit) -- Armazém de craft do terminal 
local CRAFTINGSTORAGE = peripheral.wrap(CrafttingDeposit) ----------------- Armazém de craft
local RESULT = peripheral.wrap(NameResultInventoury) ---------------------- Armazém de tramitação de saida
local STORE = peripheral.wrap(NameStoreInventoury) ------------------------ Armazém de tramitação de entrada
----- Variáveis -----
local ALA_UPT = 0 ----------------------------- Intervalor de atualização de ALA
local ALI_UPT = 0.5 --------------------------- Intervalo de atualização de ALI
local ALIP_UPT = 0 ---------------------------- Intervalo de atualização de ALIP
local AT_UPT = 0 ------------------------------ Intervalo de atualização de AT
local AI_UPT = 0 ------------------------------ Intervalo de atualização de AI
local EC_UPT = 0 ------------------------------ Intervalo de atualização de EC
local G_TotalItems = {} ----------------------- Lista com todos os items
local G_SearchItems = {} ---------------------- Lista com todos os items realtivos a pesquisa
local G_SearchWord = "" ----------------------- Paralvra usada para pesquisa
local DisplayWindow = 0 ----------------------- Referente a janela atual
local SelectedItem = nil ---------------------- Item selecionado 
local ScrollItems = 1 ------------------------- Relativo ao scroll da tela de items
local Commands = {} --------------------------- Queue de comandos {"Função",{parâmetros}}
local ItemsChange = {} ------------------------ Queue raltivo a atualização da lista de items {"+/-",Item}
local CraftList = {} -------------------------- Queue relativo a crafts a serem feitos {CraftClass,CraftClass}
local Recipes = nil --------------------------- Lista das recipes
local SearchRecipes = {} ---------------------- Lista das recipes de pesquisas
local TerminalRecipes = {} -------------------- Queue de recipes do terminal
local Get64 = false --------------------------- Quantos items pegar no touch do terminal
local GetItemLabel = "9bbbbbb55558888999999" -- Só um background 
local TerminalCraftRecipe = { ----------------- Modelo da grid do terminal
  {"","0",""},{"","0",""},{"","0",""},
  {"","0",""},{"","0",""},{"","0",""},
  {"","0",""},{"","0",""},{"","0",""}
}
local canXd = false
local RecipeAdd ={
  Type = "Craft",
  ProcessIngredients = {
    --{
      --"", -- Item.name
      --1, -- Quantidade
      --"" -- Periferico
    --}
  },
  OutputAmount = 1,
  PeriphealName = "",
  ItemName = "",
  ItemDisplayName = "",
  CraftIngredients = {
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  }
}
local CanExeCraft = true
local ScrollListIng = 1
local Resisito = {
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"}
}
local G_ListIng = {
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"},
  {"                                                   ","5555555555"}
}
local CraftApproved = true
local IdAddWriteBar = false
local RG = {"000","000","000","000","000","000","000","000","000"}
local IdRdWriteBar = false
local NameRdWriteBar = false
local IngSpnc = ""
local IdWorld = ""
local SelectedRecipe = {}
local DisplayGridItem = ""
local TerminalCraftTimes = 1 ------------------ Vezes que o craft do terminal será feito 
local ItemVerified = false -------------------- Verifica os items
local BackToSystem = true --------------------- Define se o resultado do craft do terminal vai pro sistema
local BackToSystemL = {"55","77"}
local ItemVerified = false
local SearchBarWrite = true
local xd = "_"
local RecipeTab = 0
local Rindex = 1
local Ta1 = "555550000000000000000000000000000000000000000000000"
local Ta2 = "ddddd8888888888888888888888888888888888888888888888"
local RecipesLabels = {
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
  "                                                   ",
}
-------------------
local Colors= { ----Variável tipo class das cores
  White = 1, -------Branco
  Black = 32768, ---Preto
  Green = 8192, ----verde
  Lime = 32, -------Limão
  Cyan = 512, ------Ciano
  Blue = 2048, -----Azul
  Orange = 2, ------Laranja
  Red = 16384, -----Vermelho
  Yellow = 16, -----Amarelo
  Gray = 128, ------Cinza
  LightGray = 256 --Cinza-claro
}
local G_BackgroundColor = Colors.Black -- Cor padrão de fundo (Padrão branco)
local G_TextColor = Colors.Black -------- Cor padrão do texto (Padrão preto)
local InicialVisual = { ----------------- Label de entrada
  "0000000ffff0ffff0f00f0fff0f000f00ffff000ffff0000000",
  "0000000f0000f0000f00f00f00ff0ff00000f000f00f0000000",
  "0000000f0000f0000f00f00f00f0f0f00ffff000f0ff0000000",
  "0000000f0000f0000f00f00f00f000f00f000000ff0f0000000",
  "0000000ffff0ffff0ffff0fff0f000f00ffff0f0ffff0000000",
}
local InicialLoadBar = { --------------- Label que simula uma barra de carregamento
  "58888888888888888",
  "55558888888888888",
  "55558888888888888",
  "55555555888888888",
  "55555555555555588",
  "55555555555555555"
}
local SearchLabels = { ----------------- Labels iniciais dos items
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
"                              ",
}
-------- Funções --------
-------------------------
local function ItemVerifier(NAME,LIST) --Verifica se um item está em uma lista
    if #LIST >=1 then
        for c =1, #LIST do
            if LIST[c].name == NAME then
                return c
            end 
        end
    end
    return false
end
---------------------
local function getNomenclature(n) --Nomencla numeros
    local abs_n = math.abs(n)
    local suffixes = {"u", "k", "M", "T", "P", "E"}
    local magnitude = 0
    if abs_n > 0 then
        magnitude = math.floor((math.log10(abs_n)) / 3)        
        if magnitude > #suffixes - 1 then
            magnitude = #suffixes - 1
        end
    end
    local value = n / (1000 ^ magnitude)                 
    local formatted = string.format((value % 1 == 0) and "%.0f" or "%.0f", value) 
    return string.sub(formatted .. suffixes[magnitude + 1].."   ",1,4)
end
----------------------
local function isAlnumChar(s) --Identificador de numero ou letra
    if type(s) ~= "string" or #s ~= 1 then
        return false
    end
    return s:match("^[%l%d]$") ~= nil
end
----------------------
local function Get(name,amount) -- Usado pelo sistema touch capaz de pegar items do sistema
  for i=1,#STORAGES do
    for slot, item in pairs(STORAGES[i].list()) do
      if item.name == name then
        local Item = STORAGES[i].getItemDetail(slot)
        local r = RESULT.pullItems(peripheral.getName(STORAGES[i]), slot , amount)
        if r > 0 then
          Item.count = r
          table.insert(ItemsChange,{"-",Item})
          return
        end
      end 
    end
  end
end
----------------------
local function SendTo(name,peripheralname,slotto) -- Usado pelo sistema touch capaz de pegar items do sistema
  local pp = peripheral.wrap(peripheralname)
  if pp then
    for i=1,#STORAGES do
      for slot, item in pairs(STORAGES[i].list()) do
        if item.name == name then
          local Item = STORAGES[i].getItemDetail(slot)
          local r = pp.pullItems(peripheral.getName(STORAGES[i]), slot ,1,slotto)
          if r > 0 then
            Item.count = r
            table.insert(ItemsChange,{"-",Item})
            return
          end
        end 
      end
    end
  end
end
----------------------
local function ListAllItems() ------- Lista todos os item de todos os armazens
  local RAM_ListOfItems = {}
  for c =1, #STORAGES do
    for slot, item in pairs(STORAGES[c].list()) do
      if item then
        local RAM_Item = STORAGES[c].getItemDetail(slot)
        if RAM_Item then
          local x = ItemVerifier(RAM_Item.name,RAM_ListOfItems)
          if x then
            RAM_ListOfItems[x].count = RAM_ListOfItems[x].count + RAM_Item.count
          else 
            table.insert(RAM_ListOfItems,RAM_Item)
          end
        end
      end
    end
  end
  ItemVerified = true
  G_TotalItems = RAM_ListOfItems
  if not SelectedItem then
    SelectedItem = G_TotalItems[1]
  end
end
----------------------
local function InicialDisplay() -------- Display de introdução e carregamento
  term.setBackgroundColor(Colors.Gray)
  term.clear()
  sleep(0)
  term.setBackgroundColor(Colors.White)
  for i =1,19 do
    term.setCursorPos(1,i)
    sleep(0)
    for c = 1,52 do
      term.write(" ")
    end
  end
  --
  for i =1,#InicialVisual do
    sleep(0)
    term.setCursorPos(1,i+7)
    term.blit("                                                   ",
              "000000000000000000000000000000000000000000000000000",
              InicialVisual[i])
  end
  --
  local x = 0
  for i=1,#InicialLoadBar do
    if i == (#InicialLoadBar - 1) then
      while true do
        sleep(0)
        if ItemVerified then
          break
        end
      end
    end
    sleep(0.5)
    term.setCursorPos(18,14)
    term.blit("                 ","00000000000000000",InicialLoadBar[i])
  end
  sleep(0.5)
  term.setBackgroundColor(Colors.Gray)
  term.clear()
  sleep(0)
end
--------------------
local function StorageVerify() ----- Carrega todos os inventarios de armazenamentos 
  PERIPHERALS = peripheral.getNames()
  local RAM_storage = {}
  for i = 1,#PERIPHERALS do
    local P = peripheral.wrap(PERIPHERALS[i])
    if peripheral.getType(P) == NameTypeStorage then
        table.insert(RAM_storage,P)
    end
  end
  STORAGES = RAM_storage
end
-------------------
local CALR = false
function ReadRcps() --------------- Pegas as recipes
  CALR = false
  local file = fs.open("disk/Recipes.lua","r") 
  local contents = textutils.unserialize(file.readAll())
  file.close()
  Recipes = contents
  CALR = true
end
--------------------
function WriteRcps(R) ------------- Salva recipes
  ReadRcps()
  local file = fs.open("disk/Recipes.lua","w") 
  file.write(textutils.serialize(R))
  file.close()
  ReadRcps()
end
--------------------
local function VerifyRecipeFile()
  local x = fs.open("disk/Recipes.lua","r")
  if not x  then
    local file = fs.open("disk/Recipes.lua","w") 
    file.write(textutils.serialize(
    {
      {
        Type = "Craft",
        ProcessIngredients = {
          --{
            --"", -- Item.name
            --1, -- Quantidade
            --"" -- Periferico
          --}
        },
        OutputAmount = 4,
        PeriphealName = "",
        ItemName = "minecraft:oak_planks",
        ItemDisplayName = "Oak Planks",
        CraftIngredients = {
          "minecraft:oak_log",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
        }
      },
    }
    ))
    file.close()
  else
    x.close()
    ReadRcps()
  end
end
-------------------
local function ToRightLabel(c)
  if SearchBarWrite then
    if c == "backspace" then
      G_SearchWord = G_SearchWord:sub(1, -2)
    else
      G_SearchWord = G_SearchWord .. c
    end
  elseif NameRdWriteBar then
    if c == "backspace" then
      RecipeAdd.ItemDisplayName = RecipeAdd.ItemDisplayName:sub(1, -2)
    else
      RecipeAdd.ItemDisplayName = RecipeAdd.ItemDisplayName .. c
    end
  elseif IdRdWriteBar then
    if c == "backspace" then
      RecipeAdd.ItemName = RecipeAdd.ItemName:sub(1, -2)
    else
      RecipeAdd.ItemName = RecipeAdd.ItemName .. c
    end
  elseif IdAddWriteBar then
    if c == "backspace" then
      IdWorld = IdWorld:sub(1, -2)
    else
      IdWorld = IdWorld .. c
    end
  end  
end
-------------------
local function DisableWR()
  SearchBarWrite = false
  NameRdWriteBar = false
  IdRdWriteBar = false
  IdAddWriteBar = false
end
--------------------
local ListIng = {}
local function GetDependencies()
  CanExeCraft = true
  for i =1,10 do
    G_ListIng[1] = "                                         " 
    G_ListIng[3] = "          "
    G_ListIng[3] = "bbbbbbbbbb"
  end
  
  if Rindex <= #SearchRecipes then
    ListIng = {}
    local CRecipe = SearchRecipes[Rindex]
    for i = 1, #CRecipe.CraftIngredients do
      local Ca = true
      if #ListIng == 0 and CRecipe.CraftIngredients[i] ~= "" then
        table.insert(ListIng,{CRecipe.CraftIngredients[i],(1 * TerminalCraftTimes),"eeeeeeeeee"})
        Ca = false
      elseif CRecipe.CraftIngredients[i] ~= "" then
        for t = 1, #ListIng do
          if CRecipe.CraftIngredients[i] == ListIng[t][1] then
            ListIng[t][2] = ListIng[t][2] + (1 * TerminalCraftTimes)
            Ca = false
            break
          end
        end
      end
      if Ca and CRecipe.CraftIngredients[i] ~= "" then
        table.insert(ListIng,{CRecipe.CraftIngredients[i],(1 * TerminalCraftTimes),"eeeeeeeeee"})
      end
    end

    
    for i = 1, #ListIng do
      local Caaa = true
      for t = 1, #G_TotalItems do
        if ListIng[i][1] == G_TotalItems[t].name then
          if G_TotalItems[t].count > ListIng[i][2] then
            ListIng[i][1] = string.sub(ListIng[i][1].."                                                                  ",1,41)
            ListIng[i][2] = string.sub(tostring(ListIng[i][2]).."<"..tostring(G_TotalItems[t].count).."                 ",1,10)
            ListIng[i][3] = "5555555555"
            Caaa = false
            break
          elseif G_TotalItems[t].count == ListIng[i][2] then
            ListIng[i][1] = string.sub(ListIng[i][1].."                                                                  ",1,41)
            ListIng[i][2] = string.sub(tostring(ListIng[i][2]).."="..tostring(G_TotalItems[t].count).."                 ",1,10)
            ListIng[i][3] = "1111111111"
            Caaa = false
            break
          elseif G_TotalItems[t].count < ListIng[i][2] then
            ListIng[i][1] = string.sub(ListIng[i][1].."                                                                  ",1,41)
            ListIng[i][2] = string.sub(tostring(ListIng[i][2] - G_TotalItems[t].count).."!"..tostring(G_TotalItems[t].count).."                 ",1,10)
            ListIng[i][3] = "eeeeeeeeee"
            Caaa = false
            CanExeCraft = false
            break
          end
        end
      end
      if Caaa then
        ListIng[i][1] = string.sub(ListIng[i][1].."                                                                  ",1,41)
        ListIng[i][2] = string.sub(tostring(ListIng[i][2]).."!0                      ",1,10)
        ListIng[i][3] = "eeeeeeeeee"
        CanExeCraft = false
      end

      
    end
    G_ListIng = ListIng
  end
end
----- Threads ------
local function ALRR()
  while true do
    sleep(0)
    for i = 1,10 do
      if (i + ScrollListIng - 1) <= #G_ListIng then
        local Idx = i + ScrollListIng - 1
        Resisito[i] = {G_ListIng[Idx][2]..G_ListIng[Idx][1],G_ListIng[Idx][3]}
      else
        Resisito[i] = {string.sub("                                                                                     ",1,51),"bbbbbbbbbb"}
      end
    end
  end
end
-------------------
local function ALR() -- Atualização de Lista de Recipes
  local RRl = {}
  local RSR = {}
  while true do
    sleep(0)
    if CALR then
      RRl = {}
      RSR = {}
      local RRecipes = Recipes
      if #RRecipes > 0 then
        for i=1,12 do
          if (i + ScrollItems -1) <= #RRecipes then
            if string.find(string.lower(RRecipes[i + ScrollItems -1].ItemDisplayName),string.lower(G_SearchWord)) or string.find(RRecipes[i + ScrollItems -1].ItemName,string.lower(G_SearchWord)) then
              table.insert(RRl,string.sub(string.sub(getNomenclature(RRecipes[i + ScrollItems -1].OutputAmount).."x ",1,6)..RRecipes[i + ScrollItems -1].ItemDisplayName.."                                              ",1,51))
              table.insert(RSR,RRecipes[(i + ScrollItems -1)])
            end
          end
        end
      end
      for i=1,12 do
        table.insert(RRl,"                                                   ")
      end
      SearchRecipes = RSR
      RecipesLabels = RRl
    end
  end
end
-------------------
local function AL1() ----------------Atualização de labels 1
  while true do
    sleep(0)
    if DisplayWindow == 0 then
    --------------
      local At1 = ""
      local At2 = ""
      if ScrollItems%2 == 0 then
        At1 = "555500000000000000000000000000"
        At2 = "dddd88888888888888888888888888"
      else
        At1 = "dddd88888888888888888888888888"
        At2 = "555500000000000000000000000000"
      end
    --------------
      local ItemDisplayName21 = "                     "
      local CountLabel = "                     "
      if SelectedItem then
        ItemDisplayName21 = string.sub(" "..SelectedItem.displayName.."                     ",1,21)
        CountLabel = string.sub(" Quant: "..SelectedItem.count..".u                   ",1,21)
      end
    --------------
      local SearchLabel30c = string.sub("S:"..G_SearchWord.."                              ",1,30)
      if SearchBarWrite == true then
        SearchLabel30c = string.sub("S:"..G_SearchWord..xd.."                              ",1,30)
      end
    --------------
      local CrafGBG = {
      TerminalCraftRecipe[1][2]..TerminalCraftRecipe[1][2]..TerminalCraftRecipe[2][2]..TerminalCraftRecipe[2][2]..TerminalCraftRecipe[3][2]..TerminalCraftRecipe[3][2],
      TerminalCraftRecipe[4][2]..TerminalCraftRecipe[4][2]..TerminalCraftRecipe[5][2]..TerminalCraftRecipe[5][2]..TerminalCraftRecipe[6][2]..TerminalCraftRecipe[6][2],
      TerminalCraftRecipe[7][2]..TerminalCraftRecipe[7][2]..TerminalCraftRecipe[8][2]..TerminalCraftRecipe[8][2]..TerminalCraftRecipe[9][2]..TerminalCraftRecipe[9][2],
      }
    --------------
      local t = string.sub(tostring(TerminalCraftTimes).."x      ",1,3)
    --------------
      local DGItem = string.sub(tostring(DisplayGridItem).."                                    ",1,19)
    --------------
      local TCQueue = string.sub(" Queue: "..tostring(#TerminalRecipes).."                           ",1,15)
    --------------
      GeralItems = {
        {" <          ITEMS           >      DESCRIPTION     ",    "f00000000000000000000000000000000000000000000000000","111bbbbbbbbbbbbbbbbbbbbbbbb111bbbbbbbbbbbbbbbbbbbbb"},
        {SearchLabel30c..               ItemDisplayName21     ,    "ffffffffffffffffffffffffffffff000000000000000000000","333333333333333333333333333333999999999999999999999"},
        {SearchLabels[1]..              CountLabel            ,    "0000fffffffffffffffffffffffffff55555533333333333333",At1..                         "bbbbbbbbbbbbbbbbbbbbb"},
        {SearchLabels[2]..             "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At2..                         "999999999999999999999"},
        {SearchLabels[3]..             "  GET : 01  64       ",    "0000fffffffffffffffffffffffffff000000ffffffffffffff",At1..                         GetItemLabel},
        {SearchLabels[4]..             "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At2..                         "999999999999999999999"},
        {SearchLabels[5]..             "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At1..                         "999999999999999999999"},
        {SearchLabels[6]..             "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At2..                         "999999999999999999999"},
        {SearchLabels[7]..             "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At1..                         "999999999999999999999"},
        {SearchLabels[8]..             "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At2..                         "999999999999999999999"},
        {SearchLabels[9]..             "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At1..                         "999999999999999999999"},
        {SearchLabels[10]..            TCQueue..      "CLEAR ",    "0000fffffffffffffffffffffffffffffffff00000000000000",At2..                         "999999999999999eeeeee"},
        {SearchLabels[11]..            ">"..DGItem..       "<",    "0000ffffffffffffffffffffffffff0fffffffffffffffffff<",At1..                         "300000000000000000003"},
        {SearchLabels[12]..            "                  sy ",    "0000ffffffffffffffffffffffffffffffffffffffffffff88f",At2..                         "333bbbbbbbb3333333333"},
        {SearchLabels[13]..            "    [][][]   <+>     ",    "0000ffffffffffffffffffffffffffff88888888fffffffffff",At1..                         "333b"..CrafGBG[1].."b3111113"..BackToSystemL[1].."3"},
        {SearchLabels[14]..            "    [][][]    "..t.."    ","0000ffffffffffffffffffffffffffff88888888fffffffffff",At2..                         "333b"..CrafGBG[2].."b3000003"..BackToSystemL[2].."3"},
        {SearchLabels[15]..            "    [][][]   <->  yu ",    "0000ffffffffffffffffffffffffffff88888888ffffffff88f",At1..                         "333b"..CrafGBG[3].."b3111113333"},
        {SearchLabels[16]..            "                     ",    "0000fffffffffffffffffffffffffffffffffffffffffffffff",At2..                         "333bbbbbbbb3333333333"},
        {SearchLabels[17]..            "        CRAFT        ",    "0000fffffffffffffffffffffffffff00000000000000000000",At1..                         "bdddddddddddddddddddb"}
      }
    elseif DisplayWindow == 1 then
      if RecipeTab == 0 then
        local t = string.sub(tostring(TerminalCraftTimes).."   ",1,2)
        ------
        local SL = string.sub(">S:"..G_SearchWord.."                                                    ",1,50)
        if SearchBarWrite == true then
          SL = string.sub(">S:"..G_SearchWord..xd.."                                                    ",1,50)
        end
        ------
        if ScrollItems%2 == 0 then
          Ta1 = "555550000000000000000000000000000000000000000000000"
          Ta2 = "ddddd8888888888888888888888888888888888888888888888"
        else
          Ta1 = "ddddd8888888888888888888888888888888888888888888888"
          Ta2 = "555550000000000000000000000000000000000000000000000"
        end
        ------
        local RDN = string.sub("                                                                       ",1,45)
        local RN = string.sub("                                                                       ",1,37)
        local RQ = string.sub("                                                                       ",1,40)
        local QL = string.sub("                                                                       ",1,13)
        if Rindex <= #SearchRecipes and Rindex ~= 0 then
          RDN = string.sub("  "..SearchRecipes[Rindex].Type..": "..SearchRecipes[Rindex].ItemDisplayName.."                                                                ",1,45)
          RN = string.sub(" "..SearchRecipes[Rindex].ItemName.."                                                                       ",1,37)
          RQ = string.sub("  Output: "..SearchRecipes[Rindex].OutputAmount.."x "..tostring(SearchRecipes[Rindex].OutputAmount * TerminalCraftTimes)..".u                                                             ",1,40)
          QL = string.sub(tostring(#CraftList).."                                                              ",1,13)
        end
        ------                          
        GeralItems = {
          {" <                   RECIPES                     > "     ,"000000000000000000000000000000000000000000000000000","111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb111"},
          {" <                   REQUEST                     > "     ,"fff000000000000000000000000000000000000000000000fff","111999999999999999999999999999999999999999999999111"},
          {RecipesLabels[1]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta1                                                  },
          {RecipesLabels[2]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta2                                                  },
          {RecipesLabels[3]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta1                                                  },
          {RecipesLabels[4]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta2                                                  },
          {RecipesLabels[5]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta1                                                  },
          {RecipesLabels[6]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta2                                                  },
          {RecipesLabels[7]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta1                                                  },
          {RecipesLabels[8]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta2                                                  },
          {RecipesLabels[9]                                          ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta1                                                  },
          {RecipesLabels[10]                                         ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta2                                                  },
          {RecipesLabels[11]                                         ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta1                                                  },
          {RecipesLabels[12]                                         ,"00000ffffffffffffffffffffffffffffffffffffffffffffff",Ta2                                                  },
          {SL..                                              "<"     ,"000fffffffffffffffffffffffffffffffffffffffffffffff0","b3333333333333333333333333333333333333333333333333b"},
          {RDN                                             .." COPY ","0fffffffffffffffffffffffffffffffffffffffffffff0000f","b0000000000000000000000000000000000000bbbbbb9999999"},
          {"<"                  ..RN..           ">= + =       "     ,"333333333333333333333333333333333333333000000000000","bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb111115555555"},
          {RQ                                        ..t.."x  CRAFT ","0000000000000000000000000000000000000000ffff0fffff0","bdddddddddddddddddddddddddddddddddddddb000005555555"},
          {"  Queue: "..QL..     "CLEAR   EXCLUDE  = - =       "     ,"000000000000000000000000000000000000000000000000000","b9999999999999999999b1111111beeeeeeeeeb111115555555"}
        }
      elseif RecipeTab == 1 then
        local Insp = string.sub("  "..IngSpnc.."                                                            ",1,49)
        ---------
        local IdAdd = string.sub("  ID:"..IdWorld.."                                                             ",1,49)
        if IdAddWriteBar then
          IdAdd = string.sub("  ID:"..IdWorld..xd.."                                                           ",1,49)
        end
        --------
        local amt = string.sub(tostring(RecipeAdd.OutputAmount).."x  ",1,3)
        --------
        local IdRd = string.sub(RecipeAdd.ItemName.."                                            ",1,44)
        if IdRdWriteBar then
          IdRd = string.sub(RecipeAdd.ItemName..xd.."                                            ",1,44)
        end
        --------
        local NameRd = string.sub(" "..RecipeAdd.ItemDisplayName.."                                              ",1,42)
        if NameRdWriteBar then
          NameRd = string.sub(" "..RecipeAdd.ItemDisplayName..xd.."                                              ",1,42)
        end
        -------
        GeralItems = {
          {" <                   RECIPES                     > "      ,"000000000000000000000000000000000000000000000000000","111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb111"},
          {" <                 ADD CRAFTING                  > "      ,"fff000000000000000000000000000000000000000000000fff","111999999999999999999999999999999999999999999999111"},
          {"                                                   "      ,"000000000000000000000000000000000000000000000000000","999999999999999999999999999999999999999999999999999"},
          {"  Name:"..NameRd..                              "  "      ,"0000000ffffffffffffffffffffffffffffffffffffffffff00","99ddddd00000000000000000000000000000000000000000099"},
          {"  ID:"..IdRd..                                  "  "      ,"00000ffffffffffffffffffffffffffffffffffffffffffff00","99ddd8888888888888888888888888888888888888888888899"},
          {"  Amount - "..amt.." +                                   ","00000000fffffffffffffffffffffffffffffffffffffffff00","99dddddd1110001119999999999999999999999999999999999"},
          {"                                                   "      ,"00fffffffffffffffffffffffffffffffffffffffffffffff00","999999999999999999999999999999999999999999999999999"},
          {"                                                   "      ,"00fffffffffffffffffffffffffffffffffffffffffffffff00","933333333333333333333333333333333333333333333333339"},
          {IdAdd                                          .."  "      ,"00fffffffffffffffffffffffffffffffffffffffffffffff00","930000000000000000000000000000000000000000000000039"},
          {"                                                   "      ,"000000000000000000000000000000000000000000000000000","933333333333333333bbbbbbbbbbbbb33333333333333333339"},
          {"                    [_][_][_]                      "      ,"000000000000000000008888888888000000000000000000000","999999999999999999bb"..RG[1]..RG[2]..RG[3].."bb99999999999999999999"},
          {"                    [_][_][_]                      "      ,"000000000000000000008888888888000000000000000000000","999999999999999999bb"..RG[4]..RG[5]..RG[6].."bb99999999999999999999"},
          {"                    [_][_][_]                      "      ,"000000000000000000008888888888000000000000000000000","999999999999999999bb"..RG[7]..RG[8]..RG[9].."bb99999999999999999999"},
          {"                                                   "      ,"000000000000000000000000000000000000000000000000000","999999911111111199bbbbbbbbbbbbb99955555555599999999"},
          {"         CLEAR                       ADD           "      ,"000000000000000000000000000000000000000000000000000","999999911111111199999999399999999955555555599999999"},
          {"                                                   "      ,"000000000000000000000000000000000000000000000000000","999999911111111199999999399999999955555555599999999"},
          {"                                                   "      ,"000000000000000000000000000000000000000000000000000","999999999999999999999999399999999999999999999999999"},
          {Insp                                           .."  "      ,"888888888888888888888888888888888888888888888888888","993333333333333333333333333333333333333333333333399"},
          {"                                                   "      ,"000000000000000000000000000000000000000000000000000","999999999999999999999999999999999999999999999999999"}
        }
      elseif RecipeTab == -1 then
        local L1 = " "..string.sub(SearchRecipes[Rindex].ItemName.."                                                     ",1,49).." "
        local L2 = " "..string.sub(tostring(SearchRecipes[Rindex].OutputAmount * TerminalCraftTimes).."x "..SearchRecipes[Rindex].ItemDisplayName.."                                                     ",1,49).." "
        -------------
        GeralItems = {
          {"                     RECIPES                     X ","000000000000000000000000000000000000000000000000000","bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbeee"},
          {"                CRAFTING DETAILS                   ","000000000000000000000000000000000000000000000000000","999999999999999999999999999999999999999999999999999"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","333333333333333333333333333333333333333333333333333"},
          {L1                                                   ,"000000000000000000000000000000000000000000000000000","399999999999999999999999999999999999999999999999993"},
          {L2                                                   ,"fffffffffffffffffffffffffffffffffffffffffffffffffff","300000000000000000000000000000000000000000000000003"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","333333333333333333333333333333333333333333333333333"},
          {Resisito[1][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[1][2].. "00000000000000000000000000000000000000000"},
          {Resisito[2][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[2][2].. "00000000000000000000000000000000000000000"},
          {Resisito[3][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[3][2].. "00000000000000000000000000000000000000000"},
          {Resisito[4][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[4][2].. "00000000000000000000000000000000000000000"},
          {Resisito[5][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[5][2].. "00000000000000000000000000000000000000000"},
          {Resisito[6][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[6][2].. "00000000000000000000000000000000000000000"},
          {Resisito[7][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[7][2].. "00000000000000000000000000000000000000000"},
          {Resisito[8][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[8][2].. "00000000000000000000000000000000000000000"},
          {Resisito[9][1]                                       ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[9][2].. "00000000000000000000000000000000000000000"},
          {Resisito[10][1]                                      ,"fffffffffffffffffffffffffffffffffffffffffffffffffff",Resisito[10][2].."00000000000000000000000000000000000000000"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","333333333333333555555555555555555533333333333333333"},
          {"                      CRAFT                        ","000000000000000000000000000000000000000000000000000","333333333333333555555555555555555533333333333333333"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","333333333333333555555555555555555533333333333333333"}
        }
      elseif RecipeTab == 2 then
        GeralItems = {
          {" <                   RECIPES                     > ","000000000000000000000000000000000000000000000000000","111bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb111"},
          {" <                 ADD PROCESS                   > ","fff000000000000000000000000000000000000000000000fff","111888888888888888888888888888888888888888888888111"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"},
          {"                                                   ","000000000000000000000000000000000000000000000000000","fffffffffffffffffffffffffffffffffffffffffffffffffff"}
        }
      end
    end
  end
end
---------------------
local function AL2() --Atualização de labels 2
  local df = "                              "
  while true do
    sleep(0)
    for i =1,17 do
      if G_SearchItems then
        if i+ScrollItems-1 <= #G_SearchItems and G_SearchItems[i+ScrollItems-1].name then
          SearchLabels[i] = string.sub(getNomenclature(G_SearchItems[i+ScrollItems-1].count).." "..G_SearchItems[i+ScrollItems-1].displayName..df,1,30)
        else
          SearchLabels[i] = df
        end
      end
    end
  end
end
--------------------
local function ALI() --Atualização da lista de items
  while true do
    sleep(0)
    if #STORAGES > 0 then
      break
    end
  end
  ListAllItems()
  while true do
    sleep(ALI_UPT)
    if #ItemsChange > 0 then --{*/-,Item}
      local x = ItemVerifier(ItemsChange[1][2].name,G_TotalItems)
      if ItemsChange[1][1] == "+" then 
        if x then
          G_TotalItems[x].count = G_TotalItems[x].count + ItemsChange[1][2].count
        elseif not x then
          table.insert(G_TotalItems,ItemsChange[1][2])
        end
      elseif ItemsChange[1][1] == "-" then
        if x and G_TotalItems[x].count <= ItemsChange[1][2].count then
          table.remove(G_TotalItems, x)
        elseif x and G_TotalItems[x].count > ItemsChange[1][2].count then
          G_TotalItems[x].count = G_TotalItems[x].count - ItemsChange[1][2].count
        end
      end
      table.remove(ItemsChange, 1)
    end
  end
end
--------------------
local function ALIP() --Atualização de lista de item de pesquisa
  while true do
    sleep(ALIP_UPT)
    if G_SearchWord == "" then
      G_SearchItems = G_TotalItems
    else 
      local RAM_ListOfItems = G_TotalItems
      local RAM_SearchItems = {}
      for i=1,#RAM_ListOfItems do
        if string.find(RAM_ListOfItems[i].name,string.lower(G_SearchWord)) or
          string.find(string.lower(RAM_ListOfItems[i].displayName),string.lower(G_SearchWord)) then 
          table.insert(RAM_SearchItems,RAM_ListOfItems[i])
        end
      end
      G_SearchItems = RAM_SearchItems
    end
  end
end
--------------------
local function ALA() --Atualização da lista de armazens
  while true do
    sleep(ALA_UPT)
    StorageVerify()
  end
end
--------------------
local function AT() --Atualização de tela 51x19
  InicialDisplay()
  while true do
    sleep(AT_UPT)
    term.setBackgroundColor(G_BackgroundColor)
    term.clear()
    if GeralItems then
      for i=1,#GeralItems do
        term.setCursorPos(1,i)
        term.blit(GeralItems[i][1],GeralItems[i][2],GeralItems[i][3])
      end
    end
  end
end
--------------------
local function IT1() --Identificação de toque
  while true do
    sleep(0)
    local event, button, x, y = os.pullEvent("mouse_click")
    local Index = (y + ScrollItems) - 3
    if y == 1 and x >= 1 and x <= 3 and button == 1 then
      if DisplayWindow == 1 then
        DisplayWindow = 0
      end
    elseif y == 1 and x >= 28 and x<= 30 and button == 1 then
      if DisplayWindow == 0 then
        DisplayWindow = 1
      end      
    end
    
    if DisplayWindow == 1 then
    
      if y == 2 and x >= 1 and x <= 3 and RecipeTab > 0 and button == 1 then
        RecipeTab = RecipeTab - 1
      elseif y == 2 and x >= 49 and x <= 51 and RecipeTab < 2 and button == 1 then
        RecipeTab = RecipeTab + 1
      end

      if RecipeTab == -1 then
        if x >= 16 and x <= 35 and y >= 17 and y <= 19 and CanExeCraft then
          for i = 1, TerminalCraftTimes do
            table.insert(CraftList,SelectedRecipe)
          end
          RecipeTab = 0
        elseif y == 1 and x >= 49 and x <= 51 then
          RecipeTab = 0
        end 
      end
      
      if RecipeTab == 1 then
      
        if x >= 35 and x <= 43 and y >= 14 and y <=16 then
          if RecipeAdd.ItemName ~= "" and RecipeAdd.ItemDisplayName ~= "" then
            table.insert(Recipes,RecipeAdd)
            WriteRcps(Recipes)
          end
        end
        
        if y == 11 and x >= 21 and x <= 23 then
          local IdGrid = 1
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 11 and x >= 24 and x <= 26 then
          local IdGrid = 2
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 11 and x >= 27 and x <= 29 then
          local IdGrid = 3
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 12 and x >= 21 and x <= 23 then
          local IdGrid = 4
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 12 and x >= 24 and x <= 26 then
          local IdGrid = 5
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 12 and x >= 27 and x <= 29 then
          local IdGrid = 6
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 13 and x >= 21 and x <= 23 then
          local IdGrid = 7
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 13 and x >= 24 and x <= 26 then
          local IdGrid = 8
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 13 and x >= 27 and x <= 29 then
          local IdGrid = 9
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end

        if y >= 14 and y <= 16 and x >= 8 and x <= 16 then
          IngSpnc = ""
          IdWorld = ""
          RecipeAdd ={
            Type = "Craft",
            ProcessIngredients = {
              --{
                --"", -- Item.name
                --1, -- Quantidade
                --"" -- Periferico
              --}
            },
            OutputAmount = 1,
            PeriphealName = "",
            ItemName = "",
            ItemDisplayName = "",
            CraftIngredients = {
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
            }
          }
        end
          
        if y == 4 then
          if NameRdWriteBar then
            DisableWR()
          else
            DisableWR()
            NameRdWriteBar = true
          end
        end

        if y == 5 then
          if IdRdWriteBar then
            DisableWR()
          else
            DisableWR()
            IdRdWriteBar = true
          end
        end

        if y == 9 then
          if IdAddWriteBar then
            DisableWR()
          else
            DisableWR()
            IdAddWriteBar = true
          end
        end
      
        if y == 6 and x >= 9 and x <= 11 and RecipeAdd.OutputAmount > 1 then 
          if button == 1 then
            RecipeAdd.OutputAmount = RecipeAdd.OutputAmount - 1
          else
            RecipeAdd.OutputAmount = 1
          end
        elseif y == 6 and x >= 15 and x <= 17 and RecipeAdd.OutputAmount < 64 then
          if button == 1 then
            RecipeAdd.OutputAmount = RecipeAdd.OutputAmount + 1
          else
            RecipeAdd.OutputAmount = 64
          end
        end
      end
      
      if RecipeTab == 0 then
        if x >= 21 and x <= 29 and y == 19 and button == 1 then
          CraftList = {}
        elseif x >= 30 and x <= 37 and y == 19 and button == 1 then
          local Rx = Recipes
          table.remove(Rx,Rindex)
          Rindex = 0
          WriteRcps(Rx)
        end
        
        if x >= 44 and x <= 51 and y >= 17 and y <= 19 and button == 1 and Rindex <= #SearchRecipes  then
          ScrollListIng = 1
          GetDependencies()
          RecipeTab = -1
        end
        
        if y == 15 and button == 1 then
          if SearchBarWrite then
            DisableWR()
          else
            DisableWR()
            SearchBarWrite = true
          end
        end
        
        if y >= 3 and y <= 14 and button == 1 then
          Rindex = y - 2 + (ScrollItems-1)
          if SearchRecipes[Rindex] then
            ScrollListIng = 1
            GetDependencies()
            SelectedRecipe = SearchRecipes[Rindex]
          end
        end
        if y == 16 and x <= 51 and x >= 45 then
          if SearchRecipes[Rindex] then 
            RecipeAdd = SearchRecipes[Rindex]
          end
        end
        
        if y == 17 and x >= 39 and x <= 44 and TerminalCraftTimes < 64 then
          if button == 1 then
            TerminalCraftTimes = TerminalCraftTimes + 1
          else
            TerminalCraftTimes = 64
          end
        elseif y == 19 and x >= 39 and x <= 44 and TerminalCraftTimes > 1 then
          if button == 1 then
            TerminalCraftTimes = TerminalCraftTimes - 1
          else
            TerminalCraftTimes = 1
          end
        end
      end
    end
    
    if DisplayWindow == 0 then
    
      if y == 2 and x >= 1 and x <= 30 and button == 1 then
        if SearchBarWrite then
          DisableWR()
        else
          DisableWR()
          SearchBarWrite = true
        end
      end
      
      if x <= 30 and y > 2  and Index <= #G_SearchItems then
        if button == 1 then
          SelectedItem = G_SearchItems[Index]
        elseif button == 2 then
          if Get64 then 
            table.insert(Commands,{"Get",{G_SearchItems[Index].name,64}})
          else 
            table.insert(Commands,{"Get",{G_SearchItems[Index].name,1}})
          end
        end
        
      elseif x > 4 and x < 30 and y == 1 then
        ListAllItems()
        
      elseif x > 31 and x < 46 and y == 5 then
        if Get64 and button == 1 then
          Get64 = false
          GetItemLabel = "9bbbbbb55558888999999"
        elseif not Get64 and button == 1 then
          Get64 = true
          GetItemLabel = "9bbbbbb88885555999999"
        end
      end
      
      if y >= 15 and y <= 16 and x >= 49 and x <= 50 then
        if BackToSystem then
          BackToSystem = false
          BackToSystemL = {"77","55"}
        else
          BackToSystem = true
          BackToSystemL = {"55","77"}
        end
      end
      
      if y == 15 and SelectedItem then
        if x >= 35 and x <= 36 then
          if button == 1 then
            if TerminalCraftRecipe[1][1] == "" then
              TerminalCraftRecipe[1][1] = SelectedItem.name
              TerminalCraftRecipe[1][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[1][3]
            end
          else
            TerminalCraftRecipe[1][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 37 and x <= 38 then
          if button == 1 then
            if TerminalCraftRecipe[2][1] == "" then
              TerminalCraftRecipe[2][1] = SelectedItem.name
              TerminalCraftRecipe[2][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[2][3]
            end
          else
            TerminalCraftRecipe[2][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 39 and x <= 40 then
          if button == 1 then
            if TerminalCraftRecipe[3][1] == "" then
              TerminalCraftRecipe[3][1] = SelectedItem.name
              TerminalCraftRecipe[3][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[3][3]
            end
          else
            TerminalCraftRecipe[3][1] = ""
            DisplayGridItem = ""
          end
        end
      elseif y == 16 and SelectedItem then
        if x >= 35 and x <= 36 then
          if button == 1 then
            if TerminalCraftRecipe[4][1] == "" then
              TerminalCraftRecipe[4][1] = SelectedItem.name
              TerminalCraftRecipe[4][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[4][3]
            end
          else
            TerminalCraftRecipe[4][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 37 and x <= 38 then
          if button == 1 then
            if TerminalCraftRecipe[5][1] == "" then
              TerminalCraftRecipe[5][1] = SelectedItem.name
              TerminalCraftRecipe[5][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[5][3]
            end
          else
            TerminalCraftRecipe[5][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 39 and x <= 40 then
          if button == 1 then
            if TerminalCraftRecipe[6][1] == "" then
              TerminalCraftRecipe[6][1] = SelectedItem.name
              TerminalCraftRecipe[6][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[6][3]
            end
          else
            TerminalCraftRecipe[6][1] = ""
            DisplayGridItem = ""
          end
        end
      elseif y == 17 and SelectedItem then
        if x >= 35 and x <= 36 then
          if button == 1 then
            if TerminalCraftRecipe[7][1] == "" then
              TerminalCraftRecipe[7][1] = SelectedItem.name
              TerminalCraftRecipe[7][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[7][3]
            end
          else
            TerminalCraftRecipe[7][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 37 and x <= 38 then
          if button == 1 then
            if TerminalCraftRecipe[8][1] == "" then
              TerminalCraftRecipe[8][1] = SelectedItem.name
              TerminalCraftRecipe[8][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[8][3]
            end
          else
            TerminalCraftRecipe[8][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 39 and x <= 40 then
          if button == 1 then
            if TerminalCraftRecipe[9][1] == "" then
              TerminalCraftRecipe[9][1] = SelectedItem.name
              TerminalCraftRecipe[9][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[9][3]
            end
          else
            TerminalCraftRecipe[9][1] = ""
            DisplayGridItem = ""
          end
        end
      end
      
      if y == 15 and x >= 44 and x <= 46 and TerminalCraftTimes < 64 then
        if button == 1 then
          TerminalCraftTimes = TerminalCraftTimes + 1
        else
          TerminalCraftTimes = 64
        end
      elseif y == 17 and x >= 44 and x <= 46 and TerminalCraftTimes > 1 then
        if button == 1 then
          TerminalCraftTimes = TerminalCraftTimes - 1
        else
          TerminalCraftTimes = 1
        end
      end
      
      if y == 19 and x >= 32 and x <= 50 then
        local cp = false
        for t =1,9 do
          if TerminalCraftRecipe[t][1] ~= "" then
            cp = true
          end
        end
        if cp then
          for o = 1,TerminalCraftTimes do 
            table.insert(
              TerminalRecipes,
              {
                TerminalCraftRecipe[1][1],TerminalCraftRecipe[2][1],TerminalCraftRecipe[3][1],
                TerminalCraftRecipe[4][1],TerminalCraftRecipe[5][1],TerminalCraftRecipe[6][1],
                TerminalCraftRecipe[7][1],TerminalCraftRecipe[8][1],TerminalCraftRecipe[9][1]
              })
          end
        end
      end
      
      if y == 12 and x >= 46 and x <= 51 then
        TerminalRecipes = {}
      end
      
    end
  end
end
--------------------
local function XD()
  while true do
    sleep(.5)
    if xd == " " then
      xd = "_"
    elseif xd == "_" then
      xd = " "
    end
  end
end
--------------------
local function IT2() --Identificação de toque
  while true do
    sleep(0)
    local event, button, x, y = os.pullEvent("mouse_drag")
    local Index = (y + ScrollItems) -3

    if DisplayWindow == 1 then
      if RecipeTab == 1 then
        if y == 11 and x >= 21 and x <= 23 then
          local IdGrid = 1
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 11 and x >= 24 and x <= 26 then
          local IdGrid = 2
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 11 and x >= 27 and x <= 29 then
          local IdGrid = 3
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 12 and x >= 21 and x <= 23 then
          local IdGrid = 4
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 12 and x >= 24 and x <= 26 then
          local IdGrid = 5
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 12 and x >= 27 and x <= 29 then
          local IdGrid = 6
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 13 and x >= 21 and x <= 23 then
          local IdGrid = 7
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 13 and x >= 24 and x <= 26 then
          local IdGrid = 8
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
        if y == 13 and x >= 27 and x <= 29 then
          local IdGrid = 9
          if button == 1 then
            if RecipeAdd.CraftIngredients[IdGrid] == "" then
              RecipeAdd.CraftIngredients[IdGrid] = IdWorld
              IngSpnc = IdWorld
            else
              IngSpnc = RecipeAdd.CraftIngredients[IdGrid]
            end
          else
            RecipeAdd.CraftIngredients[IdGrid] = ""
            IngSpnc = ""
          end
        end
      end
    end
    
    if DisplayWindow == 0 then
      if x <= 30 and y > 2  and Index <= #G_SearchItems then
        if DisplayWindow == 0 then
          if button == 2 then
            if Get64 then 
              table.insert(Commands,{"Get",{G_SearchItems[Index].name,64}})
            else 
              table.insert(Commands,{"Get",{G_SearchItems[Index].name,1}})
            end
          end
        end
      end
      
      if y == 15 and SelectedItem then
        if x >= 35 and x <= 36 then
          if button == 1 then
            if TerminalCraftRecipe[1][1] == "" then
              TerminalCraftRecipe[1][1] = SelectedItem.name
              TerminalCraftRecipe[1][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[1][3]
            end
          else
            TerminalCraftRecipe[1][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 37 and x <= 38 then
          if button == 1 then
            if TerminalCraftRecipe[2][1] == "" then
              TerminalCraftRecipe[2][1] = SelectedItem.name
              TerminalCraftRecipe[2][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[2][3]
            end
          else
            TerminalCraftRecipe[2][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 39 and x <= 40 then
          if button == 1 then
            if TerminalCraftRecipe[3][1] == "" then
              TerminalCraftRecipe[3][1] = SelectedItem.name
              TerminalCraftRecipe[3][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[3][3]
            end
          else
            TerminalCraftRecipe[3][1] = ""
            DisplayGridItem = ""
          end
        end
      elseif y == 16  and SelectedItem then
        if x >= 35 and x <= 36 then
          if button == 1 then
            if TerminalCraftRecipe[4][1] == "" then
              TerminalCraftRecipe[4][1] = SelectedItem.name
              TerminalCraftRecipe[4][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[4][3]
            end
          else
            TerminalCraftRecipe[4][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 37 and x <= 38 then
          if button == 1 then
            if TerminalCraftRecipe[5][1] == "" then
              TerminalCraftRecipe[5][1] = SelectedItem.name
              TerminalCraftRecipe[5][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[5][3]
            end
          else
            TerminalCraftRecipe[5][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 39 and x <= 40 then
          if button == 1 then
            if TerminalCraftRecipe[6][1] == "" then
              TerminalCraftRecipe[6][1] = SelectedItem.name
              TerminalCraftRecipe[6][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[6][3]
            end
          else
            TerminalCraftRecipe[6][1] = ""
            DisplayGridItem = ""
          end
        end
      elseif y == 17  and SelectedItem then
        if x >= 35 and x <= 36 then
          if button == 1 then
            if TerminalCraftRecipe[7][1] == "" then
              TerminalCraftRecipe[7][1] = SelectedItem.name
              TerminalCraftRecipe[7][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[7][3]
            end
          else
            TerminalCraftRecipe[7][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 37 and x <= 38 then
          if button == 1 then
            if TerminalCraftRecipe[8][1] == "" then
              TerminalCraftRecipe[8][1] = SelectedItem.name
              TerminalCraftRecipe[8][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[8][3]
            end
          else
            TerminalCraftRecipe[8][1] = ""
            DisplayGridItem = ""
          end
        elseif  x >= 39 and x <= 40 then
          if button == 1 then
            if TerminalCraftRecipe[9][1] == "" then
              TerminalCraftRecipe[9][1] = SelectedItem.name
              TerminalCraftRecipe[9][3] = SelectedItem.displayName
            else
              DisplayGridItem = TerminalCraftRecipe[9][3]
            end
          else
            TerminalCraftRecipe[9][1] = ""
            DisplayGridItem = ""
          end
        end
      end
    end
  end
end
--------------------
local function AI() --Armazenamento de items
  while true do
    sleep(0)
    if ItemVerified then
      break
    end
  end
  while true do
    sleep(AI_UPT)
    if peripheral.wrap(NameStoreInventoury) then
      for slotm =1, 27 do
        local Item = STORE.getItemDetail(slotm)
        if Item then
          for p = 1,#STORAGES do
            local r = STORE.pushItems(peripheral.getName(STORAGES[p]), slotm , 64)
            if r > 0 then
              local i = Item
              i.count = r
              table.insert(ItemsChange,{"+",i})
              sleep(0)
            end
          end
        end
      end
    end
  end
end
--------------------
local function EC() --Execução de comandos
  while true do
    sleep(EC_UPT)
    if #Commands > 0 then
      if Commands[1][1] == "Get" then
        Get(Commands[1][2][1],Commands[1][2][2])
        table.remove(Commands, 1)
      end
    end
  end
end
--------------------
local function ELC() --Execução da lista de crafting
  while true do
    sleep(0) 
    local Current = CraftList[1]
    if Current then
      if Current.Type == "Craft" then
        for i=1,9 do
          SendTo(Current.CraftIngredients[i],CrafttingDeposit,i)
        end
        rednet.send(IdCraftTurtle,Current.CraftIngredients)
        local ID,MSG = rednet.receive()
        if BackToSystem then
          for slotm =1, 9 do
            local Item = CRAFTINGSTORAGE.getItemDetail(slotm)
            if Item then
              for p = 1,#STORAGES do
                local r = CRAFTINGSTORAGE.pushItems(peripheral.getName(STORAGES[p]), slotm , 64)
                if r > 0 then
                  local i = Item
                  i.count = r
                  table.insert(ItemsChange,{"+",i})
                  sleep(0)
                end
              end
            end
          end
        else
          for slotm =1, 9 do
            local Item = CRAFTINGSTORAGE.getItemDetail(slotm)
            if Item then
              local r = CRAFTINGSTORAGE.pushItems(peripheral.getName(RESULT), slotm , 64)
              sleep(0)
            end
          end
          for slotm =1, 9 do
            local Item = CRAFTINGSTORAGE.getItemDetail(slotm)
            if Item then
              for p = 1,#STORAGES do
                local r = CRAFTINGSTORAGE.pushItems(peripheral.getName(STORAGES[p]), slotm , 64)
                if r > 0 then
                  local i = Item
                  i.count = r
                  table.insert(ItemsChange,{"+",i})
                  sleep(0)
                end
              end
            end
          end
        end      
        table.remove(CraftList,1)
      end
    end
  end
end
--------------------
local function ELCT() --Execução da lista de crafting do terminal
  while true do
    sleep(0) 
    local Current = TerminalRecipes[1]
    if Current then
      for i=1,9 do
        SendTo(Current[i],TerminalCrafttingDeposit,i)
      end
      rednet.send(IdTerminalCraftTurtle,Current)
      local ID,MSG = rednet.receive()
      if BackToSystem then
        for slotm =1, 9 do
          local Item = MONITORCRAFTINGSTORAGE.getItemDetail(slotm)
          if Item then
            for p = 1,#STORAGES do
              local r = MONITORCRAFTINGSTORAGE.pushItems(peripheral.getName(STORAGES[p]), slotm , 64)
              if r > 0 then
                local i = Item
                i.count = r
                table.insert(ItemsChange,{"+",i})
                sleep(0)
              end
            end
          end
        end
      else
        for slotm =1, 9 do
          local Item = MONITORCRAFTINGSTORAGE.getItemDetail(slotm)
          if Item then
            local r = MONITORCRAFTINGSTORAGE.pushItems(peripheral.getName(RESULT), slotm , 64)
            sleep(0)
          end
        end
        for slotm =1, 9 do
          local Item = MONITORCRAFTINGSTORAGE.getItemDetail(slotm)
          if Item then
            for p = 1,#STORAGES do
              local r = MONITORCRAFTINGSTORAGE.pushItems(peripheral.getName(STORAGES[p]), slotm , 64)
              if r > 0 then
                local i = Item
                i.count = r
                table.insert(ItemsChange,{"+",i})
                sleep(0)
              end
            end
          end
        end
      end      
      table.remove(TerminalRecipes,1)
    end
  end
end
--------------------
local function SS() --Suporte e scroll
  while true do
    sleep(0)
    local event, dir, x, y = os.pullEvent("mouse_scroll")
    if DisplayWindow == 1 then
      
      if RecipeTab == 0 then
        if dir == -1 and y >= 3 and y <= 14 and ScrollItems >1 then
          ScrollItems = ScrollItems -1  
        elseif dir == 1 and y >= 3 and y <= 14 then
          ScrollItems = ScrollItems +1
        end
        
      elseif RecipeTab == -1 then
        if dir == -1 and ScrollListIng >1 then
          ScrollListIng = ScrollListIng -1  
        elseif dir == 1 then
          ScrollListIng = ScrollListIng +1
        end
        
      elseif RecipeTab == 1 then
        if y == 6 and x >= 9 and x <= 17 and RecipeAdd.OutputAmount > 1 and dir == 1 then 
          RecipeAdd.OutputAmount = RecipeAdd.OutputAmount - 1
        elseif y == 6 and x >= 9 and x <= 17 and RecipeAdd.OutputAmount < 64 and dir == -1 then
          RecipeAdd.OutputAmount = RecipeAdd.OutputAmount + 1
        end
      end
    end
    
    if DisplayWindow == 0 then
      if dir == -1 and x < 31 and ScrollItems >1 then
        ScrollItems = ScrollItems -1  
      elseif dir == 1 and x < 31 then
        ScrollItems = ScrollItems +1
      end
      if y >= 15 and y <= 18 and x >= 43 and x <= 47 and dir == -1 and TerminalCraftTimes < 64 then
        TerminalCraftTimes = TerminalCraftTimes + 1
      elseif y >= 15 and y <= 18 and x >= 43 and x <= 47 and dir == 1 and TerminalCraftTimes > 1 then
        TerminalCraftTimes = TerminalCraftTimes - 1
      end
    end
    if DisplayWindow == 1 then
      if y <= 19 and y >= 17 and x >= 39 and x <= 44 and TerminalCraftTimes < 64 and dir == -1 then
        TerminalCraftTimes = TerminalCraftTimes + 1
      elseif y <= 19 and y >= 17 and x >= 39 and x <= 44 and TerminalCraftTimes > 1 and dir == 1 then
        TerminalCraftTimes = TerminalCraftTimes - 1
      end
    end
  end
end
-------------------
local function KS() --Suporte de botões
  local Shift = false
  while true do
    sleep(0)
    local event, key, is_held = os.pullEvent("key")
    local k = keys.getName(key)
    --print(tostring(Shift))
    if k == "tab" then
      ScrollItems = 1
      ScrollListIng = 1
    end
    if isAlnumChar(k) then
      if Shift then
        ToRightLabel(string.upper(k))
        Shift = false
      else
        ToRightLabel(k)
      end
    elseif k == "backspace" then
      ToRightLabel(k)
      Shift = false
    elseif k == "space" then
      ToRightLabel(" ")
      Shift = false
    elseif k == "slash" and Shift then
      ToRightLabel(":")
      Shift = false
    elseif k == "minus" and Shift then
      ToRightLabel("_")
      Shift = false
    end
    if k == "leftShift" then
      Shift = true
    end
  end
end
--------------------
local function GU() -- Atualização de labels da grid de crafting
  while true do
    sleep(0)
    for i=1,9 do
      if TerminalCraftRecipe[i][1] == "" then
        TerminalCraftRecipe[i][2] = "0"
      else
        TerminalCraftRecipe[i][2] = "5"
      end
    end
  end
end
--------------------
local function RGU()
  while true do
    sleep(0)
    for i=1,9 do
      if RecipeAdd.CraftIngredients[i] ~= "" then
        RG[i] = "555"
      else
        RG[i] = "000"
      end
    end
  end
end
--------------------
local function Iniciate()
  local st = fs.open("startup","w")
  st.write("shell.run('"..tostring(  fs.getName(shell.getRunningProgram()):gsub("%.lua$"," ")  ).."')")
  st.close()
  VerifyRecipeFile()
  ReadRcps()
  print("Caso ocorra erros edite os perifericos")
  print("edit CCUIN_2_0,lua")
  sleep(1)
  parallel.waitForAll(
  RGU,
  AL1,
  AL2,
  ALI,
  ALA,
  ALIP,
  AT,
  IT1,
  IT2,
  EC,
  ELC,
  SS,
  KS,
  AI,
  GU,
  ELCT,
  XD,
  ALR,
  ALRR
  )  -- funções threads
end
Iniciate()
