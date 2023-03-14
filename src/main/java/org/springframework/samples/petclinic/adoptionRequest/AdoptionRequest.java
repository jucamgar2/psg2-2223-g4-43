package org.springframework.samples.petclinic.adoptionRequest;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;

import org.springframework.samples.petclinic.model.BaseEntity;
import org.springframework.samples.petclinic.owner.Owner;
import org.springframework.samples.petclinic.pet.Pet;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class AdoptionRequest extends BaseEntity{

    private Owner autor;

    @NotNull
    private String mensaje;

    @OneToMany
    private List<AdoptionResponse> respuestasDeAdopcion;

    @OneToOne(optional = true)
    private AdoptionResponse respuestaPeticion;

    @OneToOne(optional = false)
    private Pet mascota;
    
}
