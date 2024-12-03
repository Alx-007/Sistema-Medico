
% Enfermedades y sus síntomas
enfermedad(gripe, [fiebre, tos, dolor_de_garganta, dolor_de_cabeza, fatiga, escalofrios]).
enfermedad(covid19, [fiebre, tos, dificultad_respiratoria, perdida_olfato, perdida_gusto, dolor_cabeza]).
enfermedad(neumonia, [fiebre, tos, dolor_pecho, dificultad_respiratoria, fatiga, escalofrios]).
enfermedad(amigdalitis, [dolor_garganta, fiebre, dificultad_tragar, dolor_oidos, inflamacion_amigdalas]).
enfermedad(bronquitis, [tos, dolor_pecho, dificultad_respiratoria, fiebre, fatiga]).
enfermedad(sinusitis, [dolor_cabeza, congestion_nasal, fiebre, dolor_cara, secrecion_nasal]).
enfermedad(migrana, [dolor_cabeza, sensibilidad_luz, sensibilidad_ruido, nauseas, vomitos]).
enfermedad(diabetes, [sed_excesiva, orinar_frecuentemente, fatiga, vision_borrosa, perdida_peso]).
enfermedad(anemia, [fatiga, piel_palida, dificultad_respiratoria, dolor_cabeza, mareo]).
enfermedad(hipotiroidismo, [fatiga, aumento_peso, depresion, piel_seca, intolerancia_frio]).
enfermedad(hipertiroidismo, [perdida_peso, ansiedad, palpitaciones, sudoracion_excesiva, insomnio]).
enfermedad(asma, [dificultad_respiratoria, sibilancias, tos, opresion_pecho, fatiga]).
enfermedad(ulcera_gastrica, [dolor_abdominal, acidez, nauseas, vomitos, perdida_peso]).
enfermedad(gastritis, [dolor_abdominal, nausea, vomitos, ardor_estomago, distension_abdominal]).
enfermedad(colesterol_alto, [sin_sintomas, fatiga, dolor_pecho, dificultad_respiratoria]).
enfermedad(hipertension, [dolor_cabeza, mareos, vision_borrosa, palpitaciones, zumbido_oidos]).
enfermedad(insuficiencia_renal, [fatiga, hinchazon_pies, dificultad_respiratoria, nausea, picazon]).
enfermedad(artritis, [dolor_articulaciones, inflamacion, rigidez, perdida_movilidad]).
enfermedad(alergias, [estornudos, picazon_ojos, congestion_nasal, urticaria, dificultad_respiratoria]).
enfermedad(dengue, [fiebre, dolor_cabeza, dolor_articulaciones, sarpullido, fatiga]).
enfermedad(malaria, [fiebre, escalofrios, sudoracion, dolor_cabeza, nauseas]).
enfermedad(tuberculosis, [tos, fiebre, sudoracion_nocturna, perdida_peso, dolor_pecho]).
enfermedad(hepatitis, [ictericia, fatiga, fiebre, nausea, dolor_abdominal]).
enfermedad(sida, [fatiga, perdida_peso, fiebre_prolongada, sudoracion_nocturna, infecciones_recurrentes]).
enfermedad(zika, [fiebre, sarpullido, dolor_articulaciones, conjuntivitis, dolor_muscular]).
enfermedad(chikungunya, [fiebre, dolor_articulaciones, dolor_cabeza, fatiga, sarpullido]).
enfermedad(lupus, [dolor_articulaciones, fatiga, fiebre, sarpullido, perdida_cabello]).
enfermedad(alzheimer, [perdida_memoria, confusion, dificultad_planificacion, desorientacion]).
enfermedad(parkinson, [temblor, rigidez, lentitud_movimiento, inestabilidad_postural]).
enfermedad(epoc, [dificultad_respiratoria, tos_cronica, fatiga, opresion_pecho]).
enfermedad(cancer_pulmon, [tos_cronica, dolor_pecho, perdida_peso, dificultad_respiratoria]).
enfermedad(gota, [dolor_articulaciones, hinchazon, enrojecimiento, rigidez]).
enfermedad(alcoholismo, [dependencia, temblores, irritabilidad, perdida_memoria]).
enfermedad(esclerosis_multiple, [fatiga, debilidad, vision_borrosa, dificultad_equilibrio, temblores]).
enfermedad(faringitis, [dolor_garganta, fiebre, dificultad_tragar, inflamacion_garganta]).
enfermedad(meningitis, [dolor_cabeza, fiebre, rigidez_cuello, nauseas, confusion]).
enfermedad(leucemia, [fatiga, fiebre, dolor_articulaciones, infecciones_frecuentes, sangrado]).
enfermedad(sifilis, [ulceras, erupciones_cutaneas, fiebre, dolor_muscular, inflamacion_ganglios]).
enfermedad(sarampion, [fiebre, sarpullido, tos, conjuntivitis, secrecion_nasal]).
enfermedad(varicela, [sarpullido, fiebre, picazon, dolor_cabeza, fatiga]).
enfermedad(rubeola, [fiebre, sarpullido, dolor_cabeza, dolor_articulaciones]).
enfermedad(paperas, [inflamacion_glandulas, fiebre, dolor_garganta, dificultad_masticar]).
enfermedad(otitis, [dolor_oido, fiebre, secrecion_oido, dificultad_audicion]).
enfermedad(pielonefritis, [fiebre, dolor_abdominal, dolor_espalda, nausea, escalofrios]).
enfermedad(apendicitis, [dolor_abdominal, fiebre, nausea, vomitos, perdida_apetito]).
enfermedad(hernia, [dolor_abdominal, bulto_visible, malestar, dificultad_movimiento]).

% Consulta de síntomas y enfermedades
es_sintoma(Sintoma) :- enfermedad(_, Sintomas), member(Sintoma, Sintomas).
es_enfermedad(Enfermedad) :- enfermedad(Enfermedad, _).
sintomas_de(Enfermedad, Sintomas) :- enfermedad(Enfermedad, Sintomas).

% Deducción de enfermedad basada en síntomas
deducir_enfermedad(Sintomas, Enfermedad) :-
    enfermedad(Enfermedad, SintomasEnfermedad),
    subset(Sintomas, SintomasEnfermedad).
