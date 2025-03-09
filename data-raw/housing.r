# código para gerar housing dataset


# cria diretório caso não exista
if (!dir.exists("data")) {
  dir.create("data")
}

# download dos dados
url <-  "https://code.datasciencedojo.com/datasciencedojo/datasets/raw/master/Real%20Estate%20Valuation/Real%20estate%20valuation%20data%20set.xlsx"
download.file(url, destfile = "data-raw/housing.xlsx")

# leitura dos dados
dados <- readxl::read_excel("data-raw/housing.xlsx") |>
  janitor::clean_names()

# limpeza dos dados
dados <- dados |>
  transform(
    preco = y_house_price_of_unit_area,
    data_venda = x1_transaction_date,
    idade = x2_house_age,
    distancia_metro = x3_distance_to_the_nearest_mrt_station,
    numero_lojas = x4_number_of_convenience_stores
  ) |>
  subset(select = c(preco, data_venda, idade, distancia_metro, numero_lojas))

# salvar dados
saveRDS(dados, "data/housing.rds")
