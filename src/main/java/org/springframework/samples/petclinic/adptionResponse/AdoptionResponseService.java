package org.springframework.samples.petclinic.adptionResponse;

import java.util.List;
import java.util.Optional;

import org.springframework.transaction.annotation.Transactional;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdoptionResponseService {


    private AdoptionResponseRepository adoptionResponseRepository;

    @Autowired
    public AdoptionResponseService(AdoptionResponseRepository br){
        this.adoptionResponseRepository=br;
    }

    @Transactional(readOnly = true)
    public List<AdoptionResponse> getAllApplications(){
        return (List<AdoptionResponse>) adoptionResponseRepository.findAll();
    }

      @Transactional(readOnly = true)
      public Optional<AdoptionResponse> getApplicationById(Integer id){
        return adoptionResponseRepository.findById(id);
      }

      @Transactional()
      public void deleteApplicationById(Integer id){
        adoptionResponseRepository.deleteById(id);
      }

      @Transactional
      public void save(AdoptionResponse ar){
        adoptionResponseRepository.save(ar);
      }

      @Transactional(readOnly = true)
      public  Optional<AdoptionResponse> getById(Integer id){
        return adoptionResponseRepository.findById(id);
      }
}
