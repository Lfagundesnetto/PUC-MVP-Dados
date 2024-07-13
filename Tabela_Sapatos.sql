use vendas_sapatos;


CREATE TABLE Tipos (
    TipoID INT AUTO_INCREMENT PRIMARY KEY,
    Nome text
);

CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nome text
);

CREATE TABLE Materiais (
    MaterialID INT AUTO_INCREMENT PRIMARY KEY,
    Nome text
);

CREATE TABLE Cor (
    CorID INT AUTO_INCREMENT PRIMARY KEY,
    Nome text
);

CREATE TABLE Genero (
    GenID INT AUTO_INCREMENT PRIMARY KEY,
    Nome text
);

CREATE TABLE Tamanho (
    TamID INT AUTO_INCREMENT PRIMARY KEY,
    Nome text
);

INSERT INTO Tipos (Nome) VALUES
('Anabela'),
('Bota'),
('Bota Coturno'),
('Chinelo'),
('Rasteiras'),
('Salto Alto'),
('Sandálias'),
('Sapatênis'),
('Sapato Social'),
('Tênis')


INSERT INTO Categorias (Nome) VALUES
('Casual'),
('Conforto'),
('Casual & Conforto'),
('Esportivo'),
('Social/Formal'),
('Trabalho/Executivo'),
('Outdoor'),
('Verão'),
('Inverno'),
('Moda')

INSERT INTO Materiais (Nome) VALUES
('Couro'),
('Camurça'),
('Tecido'),
('Lona'),
('Sintético'),
('Borracha'),
('Plástico'),
('Tecido de malha'),
('Nylon')

INSERT INTO Cor (Nome) VALUES
('Azul'),
('Azul Marinho'),
('Bege'),
('Branco'),
('Vermelho'),
('Cinza'),
('Dourado'),
('Marrom'),
('Prata'),
('Preto'),
('Rosa')

INSERT INTO Genero (Nome) VALUES
('Feminino'),
('Masculino'),
('Unissex')

INSERT INTO Tamanho (Nome) VALUES
('35'),
('36'),
('37'),
('38'),
('39'),
('40'),
('41'),
('42'),
('43')

CREATE TABLE Calcados (
    CalcadoID INT AUTO_INCREMENT PRIMARY KEY,
    TipoID INT,
    CategoriaID INT,
    MaterialID INT,
    CorID INT,
    GenID INT,
    TamID INT,
    FOREIGN KEY (TipoID) REFERENCES Tipos(TipoID),
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),
    FOREIGN KEY (MaterialID) REFERENCES Materiais(MaterialID),
    FOREIGN KEY (CorID) REFERENCES Cor(CorID),
    FOREIGN KEY (GenID) REFERENCES Genero(GenID),
    FOREIGN KEY (TamID) REFERENCES Tamanho(TamID)    
);

   SELECT 
    Tipos.Nome AS Tipo,
    Categorias.Nome AS Categoria,
    Materiais.Nome AS Material,
    Cor.Nome as Cor,
    Genero.Nome as Genero,
    Tamanho.Nome as Tamanho
    
FROM 
    Calcados
JOIN 
    Tipos ON Calcados.TipoID = Tipos.TipoID
JOIN 
    Categorias ON Calcados.CategoriaID = Categorias.CategoriaID
JOIN 
    Materiais ON Calcados.MaterialID = Materiais.MaterialID 
JOIN 
    Cor ON Calcados.CorID = Cor.CorID 
JOIN 
    Genero ON Calcados.GenID = Genero.GenID 
JOIN 
    Tamanho ON Calcados.TamID = Tamanho.TamID; 
   
ALTER TABLE Calcados
ADD TipoNome VARCHAR(255),
ADD CategoriaNome VARCHAR(255),
ADD MaterialNome VARCHAR(255),
ADD CorNome VARCHAR(255),
ADD GenNome VARCHAR(255),
ADD TamNome VARCHAR (255);

alter table calcados modify column TamNome int;

INSERT INTO calcados (TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome)
SELECT Tipos.Nome, Categorias.Nome, Materiais.Nome, Cor.Nome, Genero.Nome, Tamanho.Nome
FROM Tipos
CROSS JOIN Categorias
CROSS JOIN Materiais
CROSS JOIN Cor 
CROSS JOIN Genero
CROSS JOIN Tamanho; 

delete from calcados where GenNome = 'Feminino' and TamNome > 40; 
delete from calcados where GenNome = 'Masculino' and TamNome < 38; 
delete from calcados where TipoNome IN ('Anabela','Rasteiras','Salto Alto','Sandálias') AND GenNome ='Masculino';
delete from calcados WHERE TipoNome not IN ('Sapatênis','Chinelo','Tênis') AND GenNome ='Unissex';
delete from calcados WHERE TipoNome IN ('Sapatênis','Sapato Social') AND GenNome ='Feminino';  

-- Polindo a Tabela de Sapatos


CREATE VIEW vw_tentativas AS
WITH Anabele AS (
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
        TipoNome = 'Anabela'
        AND MaterialNome IN ('Camurça', 'Sintético', 'Tecido')
        AND CategoriaNome IN ('Casual & Conforto', 'Moda')
        AND CorNome NOT IN ('Rosa', 'Vermelho')
),

Botas AS (
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
        TipoNome = 'Bota'
        AND MaterialNome IN ('Sintético', 'Borracha')
        AND CategoriaNome IN ('Casual', 'Outdoor', 'Inverno')
        AND CorNome IN ('Preto', 'Cinza', 'Branco')
),
  
Botas2 AS ( 
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
        TipoNome = 'Bota'
        AND MaterialNome IN ('Couro', 'Camurça')
        AND CategoriaNome IN ('Outdoor', 'Inverno', 'Moda')
        AND CorNome IN ('Preto', 'Cinza', 'Branco')
),

BotaCoturno AS (
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Bota Coturno'
       AND MaterialNome IN ('Couro', 'Lona', 'Sintético', 'Borracha')
       AND CategoriaNome IN ('Casual', 'Outdoor', 'Moda')
       AND CorNome IN ('Preto', 'Cinza', 'Branco')
),
  
Chinelo AS ( 
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Chinelo'
       AND MaterialNome IN ('Plástico')
       AND CategoriaNome IN ('Verão')
       AND CorNome NOT IN ('Bege', 'Marrom', 'Rosa', 'Vermelho')
),

Chinelo2 AS ( 
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Chinelo'
       AND MaterialNome IN ('Borracha')
       AND CategoriaNome IN ('Casual')
       AND CorNome NOT IN ('Bege', 'Marrom', 'Rosa', 'Vermelho')
),

SaltoAlto AS ( 
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Salto Alto'
       AND MaterialNome IN ('Couro', 'Camurça', 'Sintético')
       AND CategoriaNome IN ('Trabalho/Executivo', 'Social/Formal', 'Moda')
       AND CorNome NOT IN ('Bege', 'Marrom', 'Cinza', 'Azul Marinho')
),


Sandalias AS (
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Sandálias'
       AND MaterialNome = 'Tecido'
       AND CategoriaNome IN ('Casual', 'Verão', 'Moda')
       AND CorNome NOT IN ('Bege', 'Marrom', 'Rosa')
),
  
Sapatenis AS ( 
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Sapatênis'
       AND MaterialNome IN ('Couro', 'Tecido', 'Sintético', 'Lona')
       AND CategoriaNome IN ('Casual & Conforto', 'Trabalho/Executivo', 'Esportivo')
       AND CorNome IN ('Preto', 'Cinza', 'Branco', 'Azul Marinho')
),

SapatoSocial AS (
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Sapato Social'
       AND MaterialNome IN ('Couro', 'Camurça', 'Sintético')
       AND CategoriaNome IN ('Social/Formal', 'Trabalho/Executivo')
       AND CorNome IN ('Preto', 'Cinza', 'Branco', 'Azul Marinho')
),
  
Tenis AS ( 
    SELECT 
       TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome
    FROM 
        calcados
    WHERE 
       TipoNome = 'Tênis'
       AND MaterialNome IN ('Tecido de malha', 'Sintético', 'Borracha', 'Nylon')
       AND CategoriaNome IN ('Casual & Conforto', 'Outdoor', 'Esportivo')
       AND CorNome NOT IN ('Prata', 'Dourado', 'Bege', 'Vermelho', 'Rosa')
)

SELECT * FROM Anabele
UNION ALL
SELECT * FROM Botas
UNION ALL
SELECT * FROM Botas2
UNION ALL
SELECT * FROM BotaCoturno
UNION ALL
SELECT * FROM Chinelo
UNION all
SELECT * FROM Chinelo2
UNION ALL
SELECT * FROM SaltoAlto
UNION ALL
SELECT * FROM Sandalias
UNION ALL
SELECT * FROM Sapatenis
UNION ALL
SELECT * FROM SapatoSocial
UNION ALL
SELECT * FROM Tenis;


-- Criando a tabela de Sapatos

CREATE TABLE sapatos_todos AS
SELECT * FROM vw_tentativas vt ;

ALTER TABLE sapatos_todos
add SapatosID INT AUTO_INCREMENT PRIMARY key;


-- Criando os Preços dos Sapatos

ALTER TABLE sapatos_todos 
ADD PrecoBase DECIMAL,
ADD PrecoFinal DECIMAL;

update sapatos_todos 
 SET PrecoBase = CASE TipoNome
                    WHEN 'Anabela' THEN 100.00
                    WHEN 'Bota' THEN 150.00
                    WHEN 'Bota Coturno' THEN 180.00
                    WHEN 'Chinelo' THEN 30.00
                    WHEN 'Salto Alto' THEN 160.00
                    WHEN 'Sandálias' THEN 80.00
                    WHEN 'Sapatênis' THEN 100.00
                    WHEN 'Sapato Social' THEN 150.00
                    WHEN 'Tênis' THEN 170.00
                END;
  
update sapatos_todos 
SET PrecoFinal = PrecoBase + (CASE MaterialNome 
                                 WHEN 'Camurça' THEN PrecoBase * 0.25
                                 WHEN 'Tecido' THEN PrecoBase * 0.20
                                 WHEN 'Sintético' THEN PrecoBase * 0.15
                                 WHEN 'Borracha' THEN PrecoBase * 0.15
                                 WHEN 'Couro' THEN PrecoBase * 0.30
                                 WHEN 'Lona' THEN PrecoBase * 0.10
                                 WHEN 'Plástico' THEN PrecoBase * 0.13
                                 WHEN 'Tecido de malha' THEN PrecoBase * 0.32
                                 WHEN 'Nylon' THEN PrecoBase * 0.18
                                 ELSE 0
                               END);


-- Criando a Tabela Final de Sapatos                       
                              
create view Tabela_Produtos as (
 select SapatosID, TipoNome, CategoriaNome,  MaterialNome, CorNome, GenNome, TamNome, PrecoFinal
    FROM 
       sapatos_todos st
  );

 CREATE TABLE produtos_tabela AS
SELECT * FROM tabela_produtos tp  ;

   
    
