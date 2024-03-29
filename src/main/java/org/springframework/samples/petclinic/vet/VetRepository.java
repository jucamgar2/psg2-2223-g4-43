
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
package org.springframework.samples.petclinic.vet;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;

/**
 * Repository class for <code>Vet</code> domain objects All method names are compliant
 * with Spring Data naming conventions so this interface can easily be extended for Spring
 * Data See here:
 * http://static.springsource.org/spring-data/jpa/docs/current/reference/html/jpa.repositories.html#jpa.query-methods.query-creation
 *
 * @author Ken Krebs
 * @author Juergen Hoeller
 * @author Sam Brannen
 * @author Michael Isvy
 */
public interface VetRepository extends CrudRepository<Vet, Integer>{

	/**
	 * Retrieve all <code>Vet</code>s from the data store.
	 * @return a <code>Collection</code> of <code>Vet</code>s
	 */
	List<Vet> findAll() throws DataAccessException;

	@Query("SELECT o FROM Vet o WHERE o.id = ?1")
	Vet findByid(int id);

	@Query("SELECT o FROM Specialty o")
    List<Specialty> findAllSpecialty();

	Vet findById(int id) throws DataAccessException;
	@Modifying
    @Query(value="DELETE FROM vet_specialties WHERE vet_id = ?1",nativeQuery = true)
    void deleteSpecialtiesVetToDelete(@Param("id") Integer id);

	@Modifying
    @Query(value="DELETE FROM vets WHERE id = ?1",nativeQuery = true)
    void deleteVet(@Param("id") Integer id);

	@Query("SELECT v FROM Vet v JOIN v.user u WHERE u.username = :username")
    Vet findByUsername(String username);
}
