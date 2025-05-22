# Editor de Link (Windows)

Resolvi desenvolver para tirar um problema de compartibilidade de um IDE (Ambiente de Desenvolvimento Integrado) ao criar os atalhos no menu pelo Wine, os atalhos foram criados, mas com erros, não inicializavam, também pelo jogo Castlevania Lords Of Shadow 1 que dava um erro ao criar um atalho com o arquivo “*.desktop”, mas o executável do jogo funcionava perfeitamente na pasta do jogo e por fim para executáveis que criam arquivos “*.log” ou "*.txt" que poluem a Área de Trabalho quando são executados.

Depois, irei colocar esse tópico no site do **Wine HQ** e ver se pode ser tornar nativo no Wine, pois resolveria o problema de compartibilidade quando o Wine não consegue instalar corretamente os atalhos no menu do usuário. Assim, o usuário poderia criar manualmente esses atalhos ou editá-los.

Esse executável suportado tanto no Windows, qualquer versão, incluindo o XP, como também no Wine (Linux) para editar ou criar arquivos, *.lnk, usados pelo Windows. Com esse aplicativo, você poderá criar esses links no Wine e usá-los nos arquivos, *.desktop, nativo do **Linux**, com o comando:

**Exec=env WINEPREFIX="/home/usuario/.wine" wine "/home/usuário/arquivo.lnk"**

Dúvidas ou sugestões, estou à disposição.
