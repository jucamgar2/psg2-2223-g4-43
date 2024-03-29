/*
 * Copyright 2002-2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.samples.petclinic.pet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.samples.petclinic.pet.exceptions.DuplicatedPetNameException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 * Mostly used as a facade for all Petclinic controllers Also a placeholder
 * for @Transactional and @Cacheable annotations
 *
 * @author Michael Isvy
 */
@Service
public class PetService {

	private PetRepository petRepository;
	
	private VisitRepository visitRepository;
	

	@Autowired
	public PetService(PetRepository petRepository,
			VisitRepository visitRepository) {
		this.petRepository = petRepository;
		this.visitRepository = visitRepository;
	}

	@Transactional(readOnly = true)
	public Collection<PetType> findPetTypes() throws DataAccessException {
		return petRepository.findPetTypes();
	}
	
	@Transactional
	public void saveVisit(Visit visit) throws DataAccessException {
		visitRepository.save(visit);
	}

	@Transactional(readOnly = true)
	public Pet findPetById(int id) throws DataAccessException {
		return petRepository.findById(id);
	}
	@Transactional
	public void deletePet(int id){
		petRepository.deletePet(id);
	}
	@Transactional
	public void deleteVisit(int id){
		visitRepository.deleteVisit(id);
	}
	@Transactional
	public List<Visit> obteinVisits(List<Pet> pets){
		List<Visit> result= new ArrayList<>();
		for (int i=0;i<pets.size();i++){
			List<Visit> listVisit= pets.get(i).getVisits();
			for(int e=0;e<listVisit.size();e++){
				result.add(listVisit.get(e));
			}
		}
		return result;
	}
	@Transactional
	public Visit findVisitById(Integer i){
		return visitRepository.findById(i);
	}

	@Transactional(rollbackFor = DuplicatedPetNameException.class)
	public void savePet(Pet pet) throws DataAccessException, DuplicatedPetNameException {
			if(pet.getOwner()!=null){
				Pet otherPet=pet.getOwner().getPetwithIdDifferent(pet.getName(), pet.getId());
            	if (otherPet !=null &&StringUtils.hasLength(pet.getName()) &&  (otherPet!= null && !otherPet.getId().equals(pet.getId()))) {            	
            		throw new DuplicatedPetNameException();
            	}else
                	petRepository.save(pet);                
			}else
				petRepository.save(pet);
	}

	public List<Pet> getAllPets(){
		return petRepository.findAll();
	}

	public Collection<Visit> findVisitsByPetId(int petId) {
		return visitRepository.findByPetId(petId);
	}

	public List<Pet> getPetsByOwnerUsername(String username){
		List<Pet> pets = getAllPets();
        List<Pet> petsFiltered = pets.stream()
                    .filter(x->x.getOwner().getUser().getUsername().equals(username))
                    .collect(Collectors.toList());
		return petsFiltered;
	}

}
