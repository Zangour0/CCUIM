# ComputerCraft Ultimate Inventory Management 2.0 (CCUIM 2.0)

Este é um código feito por mim para me desafiar há cerca de 3 anos (a v1 não será publicada por ser muito ruim hehe). Foi criado com o intuito de simular um sistema de armazenamento de alto nível usando tudo que o **CC:Tweaked** pode oferecer. Há muitas más otimizações e requer bastante memória RAM, mas não é muito para se preocupar.

---

## CAPACIDADES

- Auto-run ao iniciar o computador.  
- Acesso a itens de armazenamento (podendo retirar ou pôr).  
- Sistema de craft no terminal, similar a diversos mods tipo StorageTech.  
- Sistema de criação e craft por receitas customizadas pelo player, salvas no disco.  

---

## VERSÃO 3.0 A CAMINHO!!

Dada a idade do código e minha evolução, em pouco tempo sairá uma nova versão com o código **completamente refeito!**

---

## PRÓXIMAS IMPLEMENTAÇÕES (3.0+)

- Melhor estrutura de código para futuras customizações por usuário.  
- Sistema de craft em cadeia para receitas que exigem outras receitas.  
- Revisão de UI.  
- Melhor sistema de criação de receitas.  
- Criação do sistema de receitas de processo.  
- Abas para visualização das filas (queues).  
- Integração de cópias de receitas diretamente (possivelmente integração com JEI).  

---

## MONTANDO

Na versão 2.0 é necessário possuir certos periféricos para o funcionamento do sistema.

Para começar, o primeiro bloco necessário é o **Advanced Computer** e, encostado a ele, um **Disk Drive**, assim como na imagem abaixo:

![Setup 1](https://github.com/user-attachments/assets/2bd27c15-4bb7-4b8e-9c6a-93311abeca0a)

Dentro do Disk Drive será preciso colocar um disco. Nele serão guardadas **todas as suas receitas**, portanto é de muita importância guardá-lo bem :).

![Disk drive](https://github.com/user-attachments/assets/50ee9ad3-f716-4d98-8ca2-62955a10d84c)

O sistema enxerga **todos os periféricos do mesmo tipo como um inventário**.  
Isso significa que, caso seja declarado o tipo `"minecraft:chest"`, o sistema usará **todos os periféricos desse tipo** como forma de armazenamento primário. Há duas formas de fazer isso:

- **INEFICIENTE:** ao declarar um tipo e possuir vários inventários do mesmo, o sistema gastará mais tempo para executar suas ações, de acordo com a quantidade de inventários e slots diferentes.

  ![Ineficiente](https://github.com/user-attachments/assets/090174c2-26bb-45e7-bf53-14a1c036722d)

- **IDEAL:** usar blocos de interface capazes de unir diversos inventários em um único ponto, ou até com slots de alta capacidade, maximiza a produtividade do sistema.

  ![Ideal](https://github.com/user-attachments/assets/d6efdc0a-b8b8-4c9e-adc6-2af441c699cf)

Vamos usar este exemplo como base. Ao ativar o modem, se conecta o periférico `"sophisticatedstorage:controller_0"`, com o tipo sendo `"sophisticatedstorage:controller"`, retirando o sufixo `_NUMERO`.

- **Tipo de Inventário:** Exemplo: `"sophisticatedstorage:controller"`

---

Para mandar e retirar itens será necessário definir mais **2 periféricos de tipo diferente do tipo de armazenamento**, com a condição de terem exatamente **27 slots internos**, por questões de otimização.  
Neste exemplo, vamos definir o barril à esquerda da imagem como inventário de entrada `"minecraft:barrel_0"`, e o da direita como saída `"minecraft:barrel_1"`.

- **Entrada:** Esquerda — Exemplo: `"minecraft:barrel_0"`  
- **Saída:** Direita — Exemplo: `"minecraft:barrel_1"`  

![Barrels](https://github.com/user-attachments/assets/f7e4c595-595d-47c8-b948-df99a8ccf581)

---

O **Rednet Modem** é necessário para a comunicação com as turtles de crafting, podendo ser do tipo **Ender Modem** ou **Wireless Modem**, se estiverem na distância necessária.  
Neste exemplo, o nome do periférico será `"modem_0"`.

- **Rednet Modem:** Exemplo: `"modem_0"`

![Modem 1](https://github.com/user-attachments/assets/8e957f52-60a2-4db8-b0fc-c0c0fd908651)  
![Modem 2](https://github.com/user-attachments/assets/bf145345-09bb-421e-bad6-1b0016c0d03a)

---

Finalmente, as **turtles**. São 2, e cada uma precisa de um inventário acima dela com **mínimo de 9 slots**.  
Uma será focada no craft do terminal, e a outra, na criação de itens usando receitas criadas pelo usuário.  
É importante definir qual delas terá cada função e pegar os IDs das turtles e o nome do periférico acima delas.  
Neste exemplo:

- **Turtle Craft do terminal:** Esquerda da imagem — Exemplo: ID 1  
- **Inventário Craft do terminal:** Esquerda — `"minecraft:barrel_2"`  
- **Turtle Craft interna:** Direita — Exemplo: ID 2  
- **Inventário Craft interno:** Direita — `"minecraft:barrel_3"`

![Turtles setup](https://github.com/user-attachments/assets/fd4b70ed-13c9-441c-a3eb-437881308779)

---

No final, o sistema deve ter os seguintes periféricos configurados:

- **Tipo de Inventário:** `"sophisticatedstorage:controller"`  
- **Entrada:** `"minecraft:barrel_0"`  
- **Saída:** `"minecraft:barrel_1"`  
- **Rednet Modem:** `"modem_0"`  
- **Turtle Craft do terminal:** ID 1  
- **Inventário Craft do terminal:** `"minecraft:barrel_2"`  
- **Turtle Craft interna:** ID 2  
- **Inventário Craft interno:** `"minecraft:barrel_3"`

![Final setup](https://github.com/user-attachments/assets/48b7ff40-d91a-4985-9724-b43be7ecf53a)

---

## CONFIGURANDO

Começando pelas turtles.  
Elas são bem simples: adicione o **Ender/Wireless Modem** e a **Crafting Table** nos slots conforme a imagem abaixo.  
Rode o programa da turtle `"CraftTurtle"`.  
Após isso, apenas mantenha a turtle ligada, e o programa começará automaticamente.

Caso não possua o programa, rode o código na turtle para a versão 2.0:

    pastebin get TuZqvNiJ


![Turtle program](https://github.com/user-attachments/assets/09257ed1-abab-4bec-afdb-70bb6552099e)

Vá para o computador e edite o programa `CCUIM_2`.  
Caso não o tenha, baixe usando o seguinte código:

    pastebin get uYa4gT2W


![CCUIM download](https://github.com/user-attachments/assets/9071c65b-3f5b-4abe-894a-7a243831d626)

Ao abrir, não se assuste! Heheheh 😄  
**Apenas foque nas primeiras 8 variáveis:** cada uma delas precisa ser renomeada com os periféricos que você definiu anteriormente.  
Por definição, o código vem com nomes que você provavelmente não usará.  
Compare com os exemplos e ajuste de acordo:

**TROQUE POR:**

- `local NameTypeStorage` = **Tipo de Inventário**  
- `local NameResultInventory` = **Entrada**  
- `local NameStoreInventory` = **Saída**  
- `local IdTerminalCraftTurtle` = **Turtle Craft do terminal**  
- `local TerminalCraftingDeposit` = **Inventário Craft do terminal**  
- `local IdCraftTurtle` = **Turtle Craft interna**  
- `local CraftingDeposit` = **Inventário Craft interno**  
- `local NameRednetModem` = **Rednet Modem**

![Edit variables](https://github.com/user-attachments/assets/142f0b6a-2141-495c-9155-ee17855ed22d)

Agora rode o código `CCUIM_2`.  
Ao aparecer a seguinte tela, o sistema estará pronto para uso:

![Ready screen](https://github.com/user-attachments/assets/3a732052-257c-489f-94f2-aab0efd282c6)

---

## COMO USAR

Se tudo for bem configurado, a seguinte tela aparecerá.  
A única coisa que faltará é entender algumas noções básicas de uso.  
Para pôr itens no sistema, coloque-os no **inventário de entrada**.

**BOTÕES:**

- **LMB em S:_** — Ativa/desativa a escrita da pesquisa.  
- **LMB nos itens** — Seleciona o item para ver descrição ou usá-lo na grade (grid).  
- **LMB na grid** — “Pinta” o slot da grid com o item selecionado.  
- **RMB nos itens** — Solicita o item (ele aparecerá no inventário de saída).  
- **RMB na grid** — Apaga o item “pintado” da grid.  
- **BOTÕES < e >** — Troca de janela.  
- **ITEMS** — Atualiza a lista de itens.  
- **GET** — Faz o sistema tentar pegar 1 ou 64 do item requisitado.  
- **CRAFT** — Manda craftar (lol).  
- **< 1x >** — Quantidade de vezes que o craft será executado (suporta scroll) — min 1, max 64.  
- **CLEAR** — Apaga a lista dos crafts que serão executados (fila).  
- **sy / yu** — Define se os crafts vão para o armazém do sistema ou para o de saída (para o player).  

![Main UI](https://github.com/user-attachments/assets/ab1225f7-e0e4-41f1-b0e0-7eef20dbc6ad)

---

## Crafting (aba)

Na aba de **Crafting**, o player tem acesso às receitas criadas por ele mesmo.  
Por definição, como exemplo, o craft de **Oak Planks** já vem de fábrica, sendo usado principalmente como exemplo de recipe.

**BOTÕES:**

- **LMB em S:_** — Ativa/desativa a escrita da pesquisa.  
- **LMB na receita** — Seleciona a receita.  
- **EXCLUDE** — Exclui a receita selecionada (para excluir, a pesquisa deve estar vazia — pequeno bug).  
- **COPY** — Copia a receita selecionada para a aba de criação.  
- **+ 1x -** — Número de vezes que o craft será executado.  
- **CRAFT** — Manda craftar a receita selecionada.  
- **CLEAR** — Limpa a lista dos crafts que serão executados (fila).

![Crafting tab](https://github.com/user-attachments/assets/4183b00e-1071-4685-8818-de7b80d307b3)

---

## Criação de receitas

A aba de **criação de receitas** no momento só cria receitas do tipo “crafting table”.  
Funciona escrevendo o nome ID do item que será criado, os IDs dos ingredientes e a quantidade de saída.  
Não há verificação de ID, então escreva com atenção!

**BOTÕES:**

- **Name:** Nome da receita.  
- **ID (linha cinza):** ID do item que será criado.  
- **Amount:** Quantidade de itens criados.  
- **ID (linha branca):** ID do item ingrediente (“pinta” o slot da grid onde ele fica).  
- **RMB na grid:** Apaga o item pintado.  
- **LMB na grid:** Pinta o slot se ainda não estiver pintado.  
- **CLEAR:** Reseta tudo.  
- **ADD:** Adiciona à lista de receitas.  
- **Linha cinza abaixo:** Mostra o nome ID do item quando clicado com LMB em uma grid pintada.

![Recipe creator](https://github.com/user-attachments/assets/3c8bdf53-14a8-49ba-8829-3120b9014fb3)

Infelizmente, ainda **não está disponível** a criação e execução de receitas de processo :(

![Not available](https://github.com/user-attachments/assets/7b43dde4-0ef9-4a0a-9157-009f6e424474)

---

## APOIE-ME 💖

Caso queira me apoiar, aqui está meu **PayPal**!  
Quanto mais me apoiarem, mais dinheiro pra hambúrguer e coquinha será investido pra eu fritar minha mente na frente do PC fazendo códigos <3.

[![Suporte via Paypal](https://github.com/user-attachments/assets/8e277813-d82c-4973-8a30-ebac795e8bc8)](https://www.paypal.com/donate/?business=ZW7E4SRJ8ET36&no_recurring=0&currency_code=BRL)

<img width="192" height="192" alt="QR Code (2)" src="https://github.com/user-attachments/assets/eafaf7a0-595e-483e-8b2b-ed71f307b6e7" />

---

## NonCommercial Mod & Research License (NC-Mod-R) v1.0

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
modificar e distribuir a Obra para fins não comerciais, incluindo:

a) inclusão da Obra em Modpacks distribuídos **gratuitamente** (sem cobrança ao usuário final);
b) divulgação, marketing e demonstração **não comercial** da Obra;
c) uso em pesquisas acadêmicas e não comerciais, bem como em atividades educacionais.


Restrições:

É expressamente proibida a venda da Obra ou de cópias substanciais da Obra, físicas ou digitais,
bem como a venda de Modpacks que contenham a Obra, salvo mediante autorização prévia e por escrito
do titular dos direitos autorais.

É proibida a distribuição da Obra em troca de qualquer forma de pagamento, assinatura paga,
paywall, ou como parte de produto/serviço pago, exceto quando houver licença comercial explícita.

Não é permitido sublicenciar a Obra de forma que viole as condições acima.

Se a Obra for combinada com software sob licença incompatível que permita comercialização, tal
combinação não poderá ser usada para fins comerciais sem autorização do titular dos direitos,
e o Licenciado deve assegurar que as partes resultantes cumpram as restrições deste documento.

Este texto não concede direitos sobre marcas registradas; o uso de nomes comerciais (ex.: "CC:Tweaked")
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
Contato: [ lucas2002abc@gmail.com ]

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







