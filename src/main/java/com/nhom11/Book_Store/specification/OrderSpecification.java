package com.nhom11.Book_Store.specification;

import com.nhom11.Book_Store.model.Order;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public class OrderSpecification {
    public static Specification<Order> filterByDate(Integer year, Integer month, Integer day) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            if (year != null) {
                predicates.add(cb.equal(cb.function("YEAR", Integer.class, root.get("orderDate")), year));
            }
            if (month != null) {
                predicates.add(cb.equal(cb.function("MONTH", Integer.class, root.get("orderDate")), month));
            }
            if (day != null) {
                predicates.add(cb.equal(cb.function("DAY", Integer.class, root.get("orderDate")), day));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
