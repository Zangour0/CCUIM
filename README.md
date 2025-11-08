ComputerCraft Ultimate Inventory Management 2.0 ( CCUIM 2.0 )
 
Este é um codigo feio por mim para me desafiar a cerca de 3 anos atrás (a v1 não será
publicada por ser muito ruim hehe), foi criado com o intuito de simular um sistema de 
armazenamento de alto nível usando tudo que o CC:Tweaked pode oferecer, há muitas 
más otimizações e requer bastante da memoria RAM, más não é muito para se preocupar.

CAPACIDADES:

- Auto run ao iniciar o Computer.
- Acesso a items de armazenameno ( podendo retirar ou por ).
- Sistema de craft no terminal similar diversos mods tipo storagetech.
- Sitema de criação e craft por receitas customizadas pelo player salvas no disco.

VERSÂO 3.0 HÁ CAMINHO!!

  Dado a idade do código e minha evolução, em pouco tempo sairá uma nova versão como
codigo COMPLETAMENTE REFEITO!

PRÓXIMAS IMPLEMENTAÇÕES DA 3.0 EM DIANTE:

- Melhor estrutura de codigo para futuras customizações para cada usuário.
- Sitema de craft em cadeia para receitas que exigem receitas.
- Revisão de UI.
- Melhor sistema de criação de receitas.
- Criação do sistema de receitas de processo.
- Abas para visualização das queues.
- Integração de cópias de receitas diretamente ( possivelmente integração com JEI ) 
  
-----------------------------------------------------------------------------------------------------------------------------------------------
  
MONTANDO:

Na versão 2.0 se faz nescessário a presença de certos periféricos para o funcionamento
do sistema.

Para começar, o primeiro bloco nescessário é o Advanced computer e encostado a ele um Disk drive assim como na imagem abaixo.  

<img width="1366" height="697" alt="2025-11-08_02 52 51" src="https://github.com/user-attachments/assets/2bd27c15-4bb7-4b8e-9c6a-93311abeca0a" /> 
 
-----------------------------------------------------------------------------------------------------------------------------------------------
   
Dentro do Disk drive será preciso colocar um disco, nele será quardado TODAS AS SUAS RECEITAS, é de 
muita importância quardar ele bem :).
    
<img width="1366" height="697" alt="2025-11-08_02 53 38" src="https://github.com/user-attachments/assets/50ee9ad3-f716-4d98-8ca2-62955a10d84c" />

-----------------------------------------------------------------------------------------------------------------------------------------------
O sistema encherga **todos os perifericos do mesmo tipo como um inventário**, significa que caso seja declarado o tipo "minecraft:chest" o
sistema irá usar **todos os perifericos deste tipo** como forma de armazenamento primário. Há duas formas de fazer isso:

- **INEFICIENTE**: Neste exemplo ao declarar um tipo e possuir vário inventarios do mesmo, o sistema gastará mais tempo para executar suas ações
decorrente da quantidade de inventarios e slots diferentes.
<img width="1366" height="697" alt="2025-11-08_02 57 29" src="https://github.com/user-attachments/assets/090174c2-26bb-45e7-bf53-14a1c036722d" />
 
- **IDEAL**: Usar blocos de interfaces capazes de juntar diversos inventários em um único ponto ou até com slots de alta capacidade maximiza a 
produtividade do sistema.
<img width="1366" height="697" alt="2025-11-08_02 56 11" src="https://github.com/user-attachments/assets/d6efdc0a-b8b8-4c9e-adc6-2af441c699cf" />

Vamos Usar este exemplo como base, ao ativar o modem se conecta o priférico "sophisticatedstorage:controller_0", com o tipo sendo "sophisticatedstorage:controller"
retirando o "_NUMERO".

- **Tipo de Inventário**: Exp:"sophisticatedstorage:controller"
  
-----------------------------------------------------------------------------------------------------------------------------------------------
Para mandar e reirar item será necessário definir mais 2 periféricos de **tipo diferente do tipo de armazenamento** com a condição de ter exatamente
**27 slots internos** por questões de otimização. Neste exemplo vamos definir o barril a esquerda da imagem como inventário de entrada "minecraft:barrel_0"
e o da direita sendo a saida "minecraft:barrel_1".
- **Entrada**: Esquerda, Exp:"minecraft:barrel_0"
- **Saida**: Direita, Exp:"minecraft:barrel_1"
<img width="1366" height="697" alt="2025-11-08_02 59 26" src="https://github.com/user-attachments/assets/f7e4c595-595d-47c8-b948-df99a8ccf581" />

-----------------------------------------------------------------------------------------------------------------------------------------------

O Rednet Modem é uma nescessário para a comunicação com as turtle de crafting, podendo ser do tipo Ender modem ou Wireless modem se estiverem
na distancia nescessária, neste exemplo o nome do periférico será "modem_0".

- **Rednet modem**: Exp:"modem_0"
  
<img width="1366" height="697" alt="2025-11-08_03 00 04" src="https://github.com/user-attachments/assets/8e957f52-60a2-4db8-b0fc-c0c0fd908651" />
<img width="1366" height="697" alt="2025-11-08_03 00 09" src="https://github.com/user-attachments/assets/bf145345-09bb-421e-bad6-1b0016c0d03a" />

-----------------------------------------------------------------------------------------------------------------------------------------------
Finalmente as turtles, são 2 as quais precisam de um inventário acima delas com o **mínimo de 9 slots**, uma será focado do craft do termial e a
outra focada para criação de items usando receitas criadas pelo usuário, importante definir quais deles vai definir qual das funções e pegar as
ids das turtles e o nome do periférico o qual está acime dele, neste exemplo:

- **Turtle Craft do terminal**: Esquerda da imagem, Exp:id 1.
- **Inventário Craft do terminal**: Esquerda da imagem, Exp:"minecraft:barrel_2".
- **Turtle Craft do interno**: Direita da imagem, Exp:id 2.
- **Inventário Craft do interno**: Direita da imagem, Exp:"minecraft:barrel_3".

<img width="1366" height="697" alt="2025-11-08_03 01 02" src="https://github.com/user-attachments/assets/fd4b70ed-13c9-441c-a3eb-437881308779" />

-----------------------------------------------------------------------------------------------------------------------------------------------

No final o sistema tem que cumprir os seguintes periféricos:

- **Tipo de Inventário**: Exp:"sophisticatedstorage:controller"
- **Entrada**: Esquerda, Exp:"minecraft:barrel_0"
- **Saida**: Direita, Exp:"minecraft:barrel_1"
- **Rednet modem**: Exp:"modem_0"
- **Turtle Craft do terminal**: Esquerda da imagem, Exp:id 1.
- **Inventário Craft do terminal**: Esquerda da imagem, Exp:"minecraft:barrel_2".
- **Turtle Craft do interno**: Direita da imagem, Exp:id 2.
- **Inventário Craft do interno**: Direita da imagem, Exp:"minecraft:barrel_3".

<img width="1366" height="697" alt="2025-11-08_03 32 59" src="https://github.com/user-attachments/assets/48b7ff40-d91a-4985-9724-b43be7ecf53a" />

-----------------------------------------------------------------------------------------------------------------------------------------------
CONFIGURANDO:

Começando com as turles. Elas são bem simples, adicione o Ender/Wireless modem e a crafting table nos slos da imagem abaixo, rode o programa da 
turtle "CraftTurtle", após isso apenas se preocupe em manter a turtle ligada e o programa começará automaticamente.

Caso não possua o programa, rode o codigo na turle para a versão 2.0:

    pastebin get TuZqvNiJ

<img width="612" height="454" alt="Captura de tela 2025-11-08 032736" src="https://github.com/user-attachments/assets/09257ed1-abab-4bec-afdb-70bb6552099e" />

-----------------------------------------------------------------------------------------------------------------------------------------------

Vá para o Computador e edite o programa CCUIM_2, caso não tenha, baixe usando o seguinte codigo:

    pastebin get uYa4gT2W

<img width="711" height="414" alt="Captura de tela 2025-11-08 033151" src="https://github.com/user-attachments/assets/9071c65b-3f5b-4abe-894a-7a243831d626" />

Ao abrir não se asuste heheheh, **APENAS FOQUE NAS PRIMEIRAS 8 VARIÁRIS**: cada uma delas precisa ser renomeados com oa periféricos os quais você
definiu anteriormente. Por definição o codigo vem com nomeações as quais você provavelmente não vai usar, usando como base os exemplos anteriores 
compare com o seu e mude de acordo:

**TROQUE POR**:

- local NameTypeStorage = **Tipo de Inventário**
- local NameResultInventoury = **Entrada**
- local NameStoreInventoury = **Saida**
- local IdTerminalCraftTurtle = **Turtle Craft do terminal**
- local TerminalCrafttingDeposit = **Inventário Craft do terminal**
- local IdCraftTurtle = **Turtle Craft do interno**
- local CrafttingDeposit = **Inventário Craft do interno**
- local NameRednetModem = **Rednet modem**

<img width="715" height="411" alt="Captura de tela 2025-11-08 033217" src="https://github.com/user-attachments/assets/142f0b6a-2141-495c-9155-ee17855ed22d" />

Agora rode o codigo CCUIM_2, ao aprecer a seguinte tela o sistema estrá pronto para o uso:

<img width="725" height="410" alt="Captura de tela 2025-11-08 033431" src="https://github.com/user-attachments/assets/3a732052-257c-489f-94f2-aab0efd282c6" />

-----------------------------------------------------------------------------------------------------------------------------------------------

COMO USAR:

Se tudo for bem setado, a seguine tela aparecerá e a única coisa que faltara é umas noções básicas de uso, para por items no sistema coloque-os no inventário
de entrada.

**BOTÕES**:

 - **LMB em S:_**: Desativa/Ativa a escrita da pesquisa.    
 - **LMB nos items**: Seleciona o item para ver descrição ou para usa-lo na grid.
 - **LMB na grid**: "Pinta" o slot da grid com o item selecionado.
 - **RMB nos items**: Requisita o item, aparecerá no invetario de saida.
 - **RMB na grid**: Apaga o item "pintado" na grid
 - **BOTÕES < e >**: Troca a janela
 - **ITEMS**: Aualiza a lista de items.
 - **GET**: faz o sistema entar pegar 1 ou 64 do item que requisitado.
 - **CRAFT**: Manda craftar, lol.
 - **< 1x >**: Quantidade de vezes que o craft será executado ( Suporta scroll ) min 1, max 64.
 - **CLEAR**: Apaga a lista dos crafts que serão executados ( queue ).
 - **sy ou yu**: Define se os crafts vão para o armazem do sistema ou pro da saida ( pro player ).

<img width="721" height="416" alt="Captura de tela 2025-11-08 033449" src="https://github.com/user-attachments/assets/ab1225f7-e0e4-41f1-b0e0-7eef20dbc6ad" />

-----------------------------------------------------------------------------------------------------------------------------------------------

Na aba de crafting, o player tem acesso as receias criados pelo próprio player, por definição como exemplo o craft de Oak planks vem de fábrica,
sendo usado principalmente como exemplo de recipe:

**BOTÕES**:
- **LMB em S:_**: Desativa/Ativa a escrita da pesquisa.
- **LMB na receita**: Seleciona a receita.
- **EXCLUDE**: Exclui a receita selecionada. (para excluir a pesquisa tem que estar vazia, pequeno bug)
- **COPY**: Copia a receita selecionada para a aba de criação de receita.
- **+ 1x -**: Vezes que o craft vai ser executado.
- **CRAFT**: Manda craftar a receita selecionada.
- **CLEAR**: Apaga a lista dos crafts que serão executados ( queue ).

<img width="722" height="401" alt="Captura de tela 2025-11-08 033507" src="https://github.com/user-attachments/assets/4183b00e-1071-4685-8818-de7b80d307b3" />

-----------------------------------------------------------------------------------------------------------------------------------------------
A aba de criação de receitas no momento só cria receitas do estilo "crafting table", funciona no momentoo escrevendo o nome id do item
que será usado, os nomes ids dos ingredientes e a quantidade de saida, não há verificação de id de item então escreva com atenção.

**BOTÕES**:
- **Name**: O nome que você quiser para a receita.
- **ID linha cinza**: O id do item que será craftado com essa receita.
- **Amount**: Quantidade de items que serão craftados.
- **ID linha branca**: Id do item ingrdiente ( escreve o nomeid, "pinta" o slot da grid onde ele fica ).
- **RMB na grid**: Apaga o item pintado da grid.
- **LMB na grid**: "Pinta" o slot da grid se ja não estiver pintado. 
- **CLEAR**: Reseta tudo.
- **ADD**: Adiciona a lista de receitas.
- **Linha cinza abaixo**: Mostra o nome id do item quando clicado com LMB em uma grid "pintada".

<img width="715" height="416" alt="Captura de tela 2025-11-08 033906" src="https://github.com/user-attachments/assets/3c8bdf53-14a8-49ba-8829-3120b9014fb3" />

-----------------------------------------------------------------------------------------------------------------------------------------------

Imfelizmente não esta disponível criação e execução de receitas processo :(

<img width="715" height="407" alt="Captura de tela 2025-11-08 033538" src="https://github.com/user-attachments/assets/7b43dde4-0ef9-4a0a-9157-009f6e424474" />

-----------------------------------------------------------------------------------------------------------------------------------------------
APOIE-ME:

![paypal-logo](https://github.com/user-attachments/assets/8e277813-d82c-4973-8a30-ebac795e8bc8)

Caso queira me apoiar aqui está meu Paypal, quanto mais me apoiarem mais dinheiro pra hamburguer e coquinha será investido para eu fritar minha
mente na frente do pc fazendo códigos <3.

- SOON, CALMA!!

-----------------------------------------------------------------------------------------------------------------------------------------------

NonCommercial Mod & Research License (NC-Mod-R) v1.0

Copyright (c) [2025] [Zangour0 / Lucas Souza]. Todos os direitos reservados.

Definições:
  "Obra" significa o código-fonte, binários, assets e documentação incluídos neste repositório.
  "Licenciado" significa a pessoa ou entidade que redistribui ou usa a Obra.
  "Modpack" significa um pacote de mods/recursos para Minecraft distribuído ao público.
  "Uso Comercial" significa venda direta, cobrança de taxa para distribuição, sublicenciamento comercial,
  ou qualquer outra exploração com fins de lucro (direto ou indireto), salvo acordo escrito em contrário.

Concessão de licença:
  Sujeito aos termos e condições abaixo, o titular dos direitos autorais concede ao Licenciado
  uma licença limitada, não exclusiva, mundial e sem royalties para usar, copiar, executar,
  modificar e distribuir a Obra para fins **não comerciais**, incluindo:

    a) inclusão da Obra em Modpacks distribuídos **gratuitamente** (sem cobrança ao usuário final);
    b) divulgação, marketing e demonstração **não comercial** da Obra;
    c) uso em pesquisas acadêmicas e não comerciais, bem como em atividades educacionais.

Restrições:
  1. É **expressamente proibida** a venda da Obra ou de cópias substanciais da Obra, físicas ou digitais,
     bem como a venda de Modpacks que contenham a Obra, salvo mediante autorização prévia e por escrito
     do titular dos direitos autorais.
  2. É proibida a distribuição da Obra em troca de qualquer forma de pagamento, assinatura paga,
     paywall, ou como parte de produto/serviço pago, exceto quando houver licença comercial explícita.
  3. Não é permitido sublicenciar a Obra de forma que viole as condições acima.
  4. Se a Obra for combinada com software sob licença incompatível que permita comercialização, tal
     combinação não poderá ser usada para fins comerciais sem autorização do titular dos direitos,
     e o Licenciado deve assegurar que as partes resultantes cumpram as restrições deste documento.
  5. Este texto não concede direitos sobre marcas registradas; o uso de nomes comerciais (ex.: "CC:Tweaked")
     pode requerer permissão adicional do titular da marca.

Atribuição:
  Qualquer redistribuição (mesmo não comercial) deve incluir:
    • Créditos ao autor original: "Copyright (c) [2025] [Zangour0 / Lucas Souza] — [CCUIM]"
    • Link para o repositório original ou para o arquivo LICENSE.
  Em Modpacks gratuitos, a atribuição deve estar visível no arquivo README/credits do Modpack.

Modificações e distribuições derivadas:
  • Modificações são permitidas para uso privado, educacional ou não comercial.
  • Redistribuições de versões modificadas seguem as mesmas restrições desta licença
    (proibição de venda e obrigação de atribuição).
  • Recomenda-se (mas não é obrigatório) publicar claramente as mudanças e manter um link para o repo original.

Compatibilidade com upstream e terceiros:
  • Se a Obra for um fork ou incorporar código com outra licença, o Licenciado deve cumprir as obrigações
    da licença upstream (incluindo cláusulas de preservação de aviso, copyleft, etc.). Em caso de conflito
    entre a licença upstream e esta licença, prevalecem as obrigações da licença upstream no que for aplicável.

Licenciamento comercial:
  • Empresas/entidades interessadas em uso comercial podem solicitar uma licença comercial diretamente ao autor.
    Contato: [lucas2002abc@gmail.com]

Isenção de garantias:
  A Obra é fornecida "NO ESTADO EM QUE SE ENCONTRA", sem qualquer garantia, expressa ou implícita.
  O autor não será responsável por quaisquer danos decorrentes do uso da Obra.

Rescisão:
  O descumprimento de qualquer condição desta licença anula automaticamente a licença concedida.
  Após rescisão, o Licenciado deve cessar a distribuição comercial ou não autorizada e remover a Obra
  das mídias em que a esteja oferecendo comercialmente.

Lei aplicável:
  Esta licença será regida e interpretada de acordo com as leis do país de residência do titular dos direitos,
  salvo acordo por escrito em contrário.

Versão:
  NonCommercial Mod & Research License (NC-Mod-R) v1.0









