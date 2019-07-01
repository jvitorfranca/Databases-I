-- Client Table
CREATE TABLE IF NOT EXISTS Cliente(
  CPF INTEGER NOT NULL,
  Email TEXT NOT NULL,
  Nome TEXT NOT NULL,
  Telefone1 INTEGER NOT NULL,
  Telefone2 INTEGER,
  Senha TEXT NOT NULL,
  UF TEXT NOT NULL,
  Bairro TEXT NOT NULL,
  CEP TEXT NOT NULL,
  PRIMARY KEY (CPF)
);

-- Look up to payment status
CREATE TABLE IF NOT EXISTS Status_Pagamento (
  Codigo INTEGER NOT NULL,
  Descricao TEXT NOT NULL,
  PRIMARY KEY (Codigo)
);

-- Look up to delivery status
CREATE TABLE IF NOT EXISTS Status_Entrega (
  Codigo INTEGER NOT NULL,
  Descricao TEXT NOT NULL,
  PRIMARY KEY (Codigo)
);

-- Look up to payment method
CREATE TABLE IF NOT EXISTS Forma_Pagamento (
  Codigo INTEGER NOT NULL,
  Descricao TEXT NOT NULL,
  PRIMARY KEY (Codigo)
);

-- Purchase Table
CREATE TABLE IF NOT EXISTS Compra (
  Numero INTEGER NOT NULL,
  Valor INTEGER NOT NULL,
  CPF_Cliente INTEGER NOT NULL,
  Codigo_Status_Pagamento INTEGER NOT NULL,
  Codigo_Status_Entrega INTEGER NOT NULL,
  Codigo_Forma_Pagamento INTEGER NOT NULL,
  PRIMARY KEY (Numero),
  FOREIGN KEY (Codigo_Status_Pagamento) REFERENCES Status_Pagamento (Codigo),
  FOREIGN KEY (Codigo_Status_Entrega) REFERENCES Status_Entrega (Codigo),
  FOREIGN KEY (Codigo_Forma_Pagamento) REFERENCES Forma_Pagamento (Codigo)
);

-- Look up to book's category
CREATE TABLE IF NOT EXISTS Categoria (
  Codigo INTEGER NOT NULL,
  Descricao TEXT NOT NULL,
  PRIMARY KEY (Codigo)
);

-- Look up to book's publisher
CREATE TABLE IF NOT EXISTS Editora (
  Codigo INTEGER NOT NULL,
  Descricao TEXT NOT NULL,
  PRIMARY KEY (Codigo)
);

-- N to N provenient table to book's author
CREATE TABLE IF NOT EXISTS Autor (
  Codigo INTEGER NOT NULL,
  Descricao TEXT NOT NULL,
  PRIMARY KEY (Codigo)
);

-- Administrator Table
CREATE TABLE IF NOT EXISTS Administrador (
  CPF INTEGER NOT NULL,
  Nome TEXT NOT NULL,
  Email TEXT NOT NULL,
  Senha TEXT NOT NULL,
  PRIMARY KEY (CPF)
);

-- Book Table
CREATE TABLE IF NOT EXISTS Livro (
  ISBN INTEGER NOT NULL,
  Nome TEXT NOT NULL,
  Descricao TEXT NOT NULL,
  Idioma TEXT NOT NULL,
  Codigo_Categoria INTEGER NOT NULL,
  Codigo_Editora INTEGER NOT NULL,
  PRIMARY KEY (ISBN),
  FOREIGN KEY (Codigo_Categoria) REFERENCES Categoria (Codigo),
  FOREIGN KEY (Codigo_Editora) REFERENCES Editora (Codigo)
);

-- Book Copy Table
CREATE TABLE IF NOT EXISTS Exemplar (
  Identificador INTEGER NOT NULL,
  Ano_Publicacao INTEGER NOT NULL,
  Num_Paginas INTEGER NOT NULL,
  Volume INTEGER NOT NULL,
  Preco REAL NOT NULL,
  Edicao TEXT NOT NULL,
  ISBN_Livro INTEGER NOT NULL,
  PRIMARY KEY (Identificador),
  FOREIGN KEY (ISBN_Livro) REFERENCES Livro
);

-- N to N provenient table of the relationship between purchase and copy of book,
CREATE TABLE IF NOT EXISTS Compra_Exemplar (
  Numero_Compra INTEGER NOT NULL,
  Identificador_Exemplar INTEGER NOT NULL,
  Quantidade INTEGER DEFAULT 1,
  PRIMARY KEY (Numero_Compra, Identificador_Exemplar),
  FOREIGN KEY (Numero_Compra) REFERENCES Compra (Numero),
  FOREIGN KEY (Identificador_Exemplar) REFERENCES Exemplar (Identificador)
);

-- N to N provenient table of the relationship between administrator and copy of book
CREATE TABLE IF NOT EXISTS Exemplar_Administrador (
  Identificador_Exemplar INTEGER NOT NULL,
  CPF_Administrador INTEGER NOT NULL,
  PRIMARY KEY (Identificador_Exemplar, CPF_Administrador),
  FOREIGN KEY (Identificador_Exemplar) REFERENCES Exemplar,
  FOREIGN KEY (CPF_Administrador) REFERENCES Administrador
);

-- N to N provenient table of the relationship between administrator and book
CREATE TABLE IF NOT EXISTS Administrador_Livro (
  CPF_Administrador INTEGER NOT NULL,
  ISBN_Livro INTEGER NOT NULL,
  PRIMARY KEY (CPF_Administrador, ISBN_Livro),
  FOREIGN KEY (CPF_Administrador) REFERENCES Administrador,
  FOREIGN KEY (ISBN_Livro) REFERENCES Livro
);

-- N to N provenient table of the relationship between book and author
CREATE TABLE IF NOT EXISTS Livro_Autor (
  ISBN_Livro INTEGER NOT NULL,
  Codigo_Autor INTEGER NOT NULL,
  PRIMARY KEY (ISBN_Livro, Codigo_Autor),
  FOREIGN KEY (ISBN_Livro) REFERENCES Livro,
  FOREIGN KEY (Codigo_Autor) REFERENCES Autor
);