import 'drug.dart';

var drugs = [
              Drug(
                // String name
                "Amissulprida",
                // List<String> type
                ["Antipsicótico de segunda geração"],
                // List<DrugAvoidCondition> avoidConditions
                [
                  DrugAvoidCondition(true,  "Independente de Condição Clinica", "Aumento do risco de acidente vascular cerebral (AVC) e mortalidade. Deve-se evitar o uso prolongado de antipsicóticos como hipnótico devido ao risco de confusão mental, hipotensão, efeitos extrapiramidais e quedas.", "O uso deve ser restrito aos casos nos quais estratégias não farmacológicas tenham falhado ou quando o paciente representa ameaça a si ou a outros."),
                  DrugAvoidCondition(false, "Constipação", "Podem agravar a constipação devido à forte ação anticolinérgica.", null),
                  DrugAvoidCondition(false, "Demência e Comprometimento Cognitivo", "Os antipsicóticos estão associados a um risco aumentado de AVC (Acidente Vascular Cerebral) e de mortalidade em pacientes com demência.", null),
                  DrugAvoidCondition(false, "História de Quedas/Fraturas", "Capacidade de produzir ataxia, comprometimento da função psicomotora, síncope e quedas adicionais. Podem ainda causar dispraxia da marcha e parkinsonismo.", null),
                  DrugAvoidCondition(false, "Sintomas do Trato Urinário Inferior (restritivos e/ ou obstrutivos) e Hiperplasia Prostática Benigna", "pode diminuir o fluxo urinário e causar retenção urinária.", null),
                  DrugAvoidCondition(false, "Doença de Parkinson", "tende a agravar os sintomas extrapiramidais.", null),
                  DrugAvoidCondition(false, "Convulsões", "Diminue o limiar convulsivo.", null),
                  DrugAvoidCondition(false, "História de Síncope", "Aumenta o risco de hipotensão ortostática ou bradicardia.", null),
                ],
                // Map<String,String> alternatives
                {
                  "Delirium":"o uso por curto período de tempo de antipsicóticos (ex. haloperidol e quetiapina) deve ser restrito a indivíduos que estão agitados e são considerados uma ameaça a si ou aos outros e nos quais as medidas não farmacológicas foram ineficazes ou são inapropriadas.",
                  "Esquizofrenia":"os agentes não anticolinérgicos podem ser aceitáveis ​​(EVITAR clorpromazina, loxapina, olanzapina, perfenazina, trifluoperazina, tioridazina)",
                  
                },
                // String desprescrition
                "Reduzir 25% à 50% da dose a cada 1-2 semanas. Se o paciente apresentar efeitos adversos graves o antipsicótico pode ser supenso abruptamente.",
                // <Map> monitoredParameters
                {},
                // <Map> references
                {
                  "Oliveira MG, Amorim WW, Oliveira CRB, Coqueiro HL, Gusmão LC, Passos LC. Consenso brasileiro de medicamentos potencialmente inapropriados para idosos. Geriatr Gerontol Aging [Internet]. 2017 Dec;10(4):168–81.":"Disponível em: http://www.ggaging.com/details/397/pt-BR/brazilian-consensus-of-potentially-inappropriate-medication-for-elderly-people",
                  "Truven Health Analytics: Drugdex® System. Thomson MICROMEDEX, Greenwood Village, Colorado, USA. [citado em: 06 Fev 2015].":"Disponível em: http://www.micromedexsolutions.com."
                }
              ),
            ];