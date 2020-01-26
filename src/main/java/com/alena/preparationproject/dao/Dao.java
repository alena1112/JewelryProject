package com.alena.preparationproject.dao;

import com.alena.preparationproject.mvc.model.IdentifiableEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceUnit;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.function.Function;

public abstract class Dao<T extends IdentifiableEntity, ID> {
    private static final Logger log = LoggerFactory.getLogger(Dao.class);

    @PersistenceUnit
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;

    public abstract Optional<T> get(ID id);

    public abstract List<T> getAll();

    public abstract void save(T t);

    public abstract void update(T t);

    public abstract void delete(ID id);

    private EntityManager getEntityManager() {
        if (entityManager == null) {
            entityManager = entityManagerFactory.createEntityManager();
        }
        return entityManager;
    }

    protected void executeInsideTransaction(Consumer<EntityManager> action) {
        EntityManager entityManager = getEntityManager();
        EntityTransaction tx = entityManager.getTransaction();
        try {
            if (!tx.isActive()) {
                tx.begin();
            }
            action.accept(entityManager);
            tx.commit();
        } catch (RuntimeException e) {
            tx.rollback();
            throw e;
        }
    }

    protected <R> R executeInsideTransaction(Function<EntityManager, R> action) {
        EntityManager entityManager = getEntityManager();
        EntityTransaction tx = entityManager.getTransaction();
        try {
            if (!tx.isActive()) {
                tx.begin();
            }
            R result = action.apply(entityManager);
            tx.commit();
            return result;
        } catch (Exception e) {
            log.error("Exception while transaction is commit", e);
            try {
                tx.rollback();
            } catch (Exception ex) {
                log.error("Exception while transaction is rollback", ex);
            }
            return null;
        }
    }

    protected boolean isDetached(T entity) {
        return entity.getId() != null;
    }
}
