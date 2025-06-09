package com.nhom11.Book_Store.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhom11.Book_Store.model.Product;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Slf4j
@Service
public class GoogleBookService {

    public Product fetchBookInfo(String isbn) throws JsonProcessingException {
        String url = UriComponentsBuilder
                .fromHttpUrl("https://www.googleapis.com/books/v1/volumes")
                .queryParam("q", "isbn:" + isbn)
                .toUriString();
        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.getForObject(url, String.class);

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(response);

        if (!root.has("items")) return null;

        JsonNode volumeInfo = root.path("items").get(0).path("volumeInfo");

        Product product = new Product();
        product.setName(volumeInfo.path("title").asText("No title"));

        if (volumeInfo.has("authors")) {
            String[] authors = mapper.convertValue(volumeInfo.get("authors"), String[].class);
            product.setAuthor(String.join(", ", authors));
        } else {
            product.setAuthor("Unknown author");
        }

        product.setDescription(volumeInfo.path("description").asText("No description"));
        product.setPublisher(volumeInfo.path("publisher").asText("Unknown publisher"));
        product.setPublishYear(volumeInfo.path("publishedDate").asInt(0));
        product.setQuantityPage(volumeInfo.path("pageCount").asInt(0));
        product.setLanguage(volumeInfo.path("language").asText("Unknown language"));
        product.setProductCode(volumeInfo.path("industryIdentifiers").get(1).path("identifier").asText());
        String urlImage = volumeInfo.path("imageLinks").path("thumbnail").asText();
        return product;
    }
}
