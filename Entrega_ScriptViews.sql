use vendas_sapatos;

create view Produtos_por_Genero as (
SELECT
    u.genero,
    p.TipoNome,
    COUNT(*) AS Quantidade
FROM 
    pedidos AS pd
INNER JOIN
    usuario_tabela AS u ON pd.usuario_id = u.usuario_id
INNER JOIN
    produtos_tabela AS p ON pd.SapatosID = p.SapatosID
GROUP by
 u.genero,
 p.TipoNome
 
 ORDER by
 u.genero,
 p.TipoNome

  );
  
 
 create view Cor_por_GFeminino as (
SELECT
   u.genero,
    p.CorNome,
    COUNT(*) AS Quantidade
FROM 
    pedidos AS pd
INNER JOIN
    usuario_tabela AS u ON pd.usuario_id = u.usuario_id
INNER JOIN
    produtos_tabela AS p ON pd.SapatosID = p.SapatosID
WHERE
    u.genero = 'Feminino'
GROUP BY
    u.genero,
    p.CorNome
ORDER BY
    Quantidade DESC,  -- Organizar de maior para menor quantidade
    p.CorNome
  );
  
  create view Cor_por_GMasculino as (
SELECT
   u.genero,
    p.CorNome,
    COUNT(*) AS Quantidade
FROM 
    pedidos AS pd
INNER JOIN
    usuario_tabela AS u ON pd.usuario_id = u.usuario_id
INNER JOIN
    produtos_tabela AS p ON pd.SapatosID = p.SapatosID
WHERE
    u.genero = 'Masculino'
GROUP BY
    u.genero,
    p.CorNome
ORDER BY
    Quantidade DESC,  -- Organizar de maior para menor quantidade
    p.CorNome
  );
  
 create view PedidosporEstado as (
SELECT
    u.nom_uf,
    COUNT(*) AS Quantidade
FROM 
    pedidos AS pd
INNER JOIN
    usuario_tabela AS u ON pd.usuario_id = u.usuario_id
INNER JOIN
    produtos_tabela AS p ON pd.SapatosID = p.SapatosID
GROUP by
 u.nom_uf
 
 ORDER by
 u.nom_uf
  );
 
 create view TamanhosGenero as (
select
   u.genero,
   p.TamNome,
   COUNT(*) AS Quantidade
FROM 
    pedidos AS pd
INNER JOIN
    usuario_tabela AS u ON pd.usuario_id = u.usuario_id
INNER JOIN
    produtos_tabela AS p ON pd.SapatosID = p.SapatosID
GROUP by
u.genero,
  p.TamNome
 
 ORDER by
 u.genero,
  p.TamNome
  );