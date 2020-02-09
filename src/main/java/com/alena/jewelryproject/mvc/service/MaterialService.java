package com.alena.jewelryproject.mvc.service;

import com.alena.jewelryproject.dao.MaterialDao;
import com.alena.jewelryproject.mvc.model.Material;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MaterialService {
    @Autowired
    private MaterialDao materialDao;

    public List<Material> getAllMaterials() {
        return materialDao.getAll();
    }
}