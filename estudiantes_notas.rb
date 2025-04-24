require "faker"

ASIGNATURAS = ["matematica", "lenguaje", "ciencias", "historia", "artes"] # Lista de asignaturas disponibles

# puts Faker::Name.name     ---- Crear nombres al azar
# puts rand(1.0..7.0).round(1)   ----- Números al azar del 1 al 7.0

# Clase estudiante
# ----------
# datos del estudiante
# sus notas (pueden ser varias de diferentes asignaturas)
# campo: hoja de vida y anotaciones      - Solo si hay tiempo
# métodos:
# calcular su promedio de notas de una asignatura(emitir una notificación cuando tenga una nota inferior 4.0 ) - Listo
# ranking de promedio de asignaturas (muestra de forma descendente sus mejores promedios en cada asignatura) - Listo
# promedio general -> Un informe de notas donde muestre los promedios de cada asignatura y su promedio - Listo
# asistencia de clases (en este ejercicio no lo veremos porque requiere bastante trabajo)   - Esto No
# Emitir mensaje personalizado de finalización de informe de notas
# agregar nota (nota, asignatura)
#----------
class Estudiante
  attr_reader :notas, :nombre, :curso, :promedio_general

  def initialize(nombre, curso = nil)
    @nombre = nombre
    @curso = curso
    @notas = {
      matematicas: [],
      lenguaje: [],
      ciencias: [],
      historia: [],
      artes: []

    }

    @rango_notas = {
      matematicas: 5, # número de notas de cada asignatura
      lenguaje: 5,
      ciencias: 3,
      historia: 3,
      artes: 2
    }

    @promedios = {
      matematicas: 0, # número de notas de cada asignatura
      lenguaje: 0,
      ciencias: 0,
      historia: 0,
      artes: 0
    }
    generar_notas
  end

  def generar_notas
    @rango_notas.each do |asignatura, cantidad|    # .each se usó para seleccionar cada asignatura, y repetir la acción "notas al azar" en cada una. Los || son los valores que "agarra" del hash
      notas_al_azar(asignatura, cantidad)
    end
  end

  def notas_al_azar(asignatura, cant_notas)    # times se usó para repetir una acción la cantidad de cant_notas (la acción que se repite es rand(1.0..7.0))
    cant_notas.times do
      nota = rand(1.0..7.0).round(1)
      agregar_notas(asignatura, nota, false)
    end
    # mostrar_notas(asignatura)
  end

  def agregar_notas(asignatura, nota, mostrar = true)
    asignatura = asignatura.to_sym  # <-- Esto convierte "matematicas" en :matematicas

    if @notas.key?(asignatura)
      if nota.between?(1.0, 7.0)
        @notas[asignatura] << nota
        mostrar_notas(asignatura) if mostrar
      else
        puts "La nota #{nota} no es válida. Debe estar entre 1.0 y 7.0."
      end
    else
      puts "No existe la asignatura #{asignatura}"
    end
  end

  def mostrar_notas(asignatura)
    puts "Las notas de #{asignatura} : #{@notas[asignatura]}"
  end

  def promedio
    @notas.each do |asignatura, notas_asignaturas|
      promedio_asignaturas = (notas_asignaturas.sum / notas_asignaturas.size).round(1)
      @promedios[asignatura] = promedio_asignaturas
      puts "El promedio de #{asignatura} es: #{promedio_asignaturas}"
      if promedio_asignaturas < 4
        puts "ALERTA la nota en #{asignatura} es menor a 4.0"
      end
    end
  end

  def ordenar_promedios
    promedios_ordenados = @promedios.sort_by { |_, promedio| promedio }
    puts "\nPromedios ordenados de menor a mayor:"
    promedios_ordenados.each do |asignatura, promedio|
      puts "#{asignatura.capitalize}: #{promedio}"
    end
  end

  def calcular_promedio_general
    calculo_promedio = (@promedios.values.sum / @promedios.length).round(1)
    @promedio_general = calculo_promedio
    puts "El promedio general es: #{calculo_promedio}"
    @promedio_general 
  end

  def mostrar_informe
    # Mensaje general según promedio
    if calculo_promedio >= 6.0
      puts "🌟 ¡Excelente rendimiento, #{nombre}!"
    elsif calculo_promedio >= 5.0
      puts "👍 Buen trabajo, #{nombre}, sigue así."
    elsif calculo_promedio >= 4.0
      puts "⚠️ Puedes mejorar, #{nombre}, no te rindas."
    else
      puts "🚨 Necesitamos más esfuerzo, #{nombre}."
    end
  end

    # Evaluación para repetir el curso
  
  def repetir_curso
    asignaturas_rojas = @promedios.count { |_, promedio| promedio < 4.0 }
    if asignaturas_rojas >= 2 && calculo_promedio < 5.0
      puts "❌ #{nombre} repite el curso por tener 2 o más asignaturas rojas y promedio bajo 5.0."
    elsif asignaturas_rojas == 1 && calculo_promedio < 4.5
      puts "❌ #{nombre} repite el curso por tener una asignatura roja y promedio menor a 4.5."
    else
      puts "✅ #{nombre} pasa de curso."
    end

    calculo_promedio
  end

  # def promedio
  #    @notas.each do |asignatura, notas_asignaturas|
  #      if notas_asignaturas.any? # Verifica que haya notas para evitar división por 0
  #        promedio_asignatura = notas_asignaturas.sum / notas_asignaturas.length.to_f
  #        puts "El promedio de #{asignatura} es: #{promedio_asignatura.round(2)}"
  #      else
  #        puts "No hay notas registradas para #{asignatura}."
  #      end
  #    end
  #  end
end

# Clase Curso
# Indetificador o nombre: Ciclo (Pre Básica, Primer Ciclo (1 a 4), Segundo Ciclo (5 a 8) y Enseñanza Media) + Número o letra (por ejemplo Kinder A, KA, etc)
# Tiene estudiantes (tiene muchas instancias /objetos de clases Estudiante)
# Métodos
# --------------------
# Ranking de Estudiantes ordenador por su promedio general
# Ranking de Estudiantes ordenador por su promedio general según asignatura (ciencias, lenguaje, matemáticas..)
# Promedio General del curso y Promedio por asignatura

class Curso
  attr_reader :nombre, :estudiantes

  def initialize(nombre, cantidad_estudiantes = 40)
    @nombre = nombre
    @estudiantes = []
    generar_estudiantes(cantidad_estudiantes)
  end

  def generar_estudiantes(cantidad)
    cantidad.times do
      nombre_aleatorio = Faker::Name.name
      estudiante = Estudiante.new(nombre_aleatorio, @nombre)
      estudiante.promedio  # Calcula los promedios por asignatura
      estudiante.calcular_promedio_general  # Calcula el promedio general y lo guarda
      @estudiantes << estudiante
    end
  end

  def mostrar_estudiantes
    puts "Estudiantes del curso #{@nombre}:"
    @estudiantes.each do |e|
      puts "- #{e.nombre}"
    end
  end

  # Método para obtener el promedio general del curso
  def promedio_general_curso
    total_promedios = @estudiantes.sum do |e|
      e.promedio ? e.calcular_promedio_general : 0
    end
    promedio_general = (total_promedios / @estudiantes.length).round(1)
    puts "\nPromedio general del curso #{@nombre}: #{promedio_general}"
  end

  # Método para mostrar el ranking del curso basado en los promedios generales
  def ranking_estudiantes
    puts "\nRanking de estudiantes por promedio general:"
    estudiantes_ordenados = @estudiantes.sort_by(&:promedio_general).reverse
    estudiantes_ordenados.each_with_index do |e, index|
      puts "#{index + 1}. #{e.nombre} - Promedio: #{e.promedio_general}"
    end
  end

  # Método para calcular el promedio por asignatura en el curso
  def promedio_por_asignatura
    asignaturas = [:matematicas, :lenguaje, :ciencias, :historia, :artes]
    asignaturas.each do |asignatura|
      total = @estudiantes.sum { |e| e.instance_variable_get(:@promedios)[asignatura] || 0 }
      promedio = (total / @estudiantes.length).round(1)
      puts "Promedio de #{asignatura.capitalize} en el curso: #{promedio}"
    end
  end
end

estudiante1 = Estudiante.new("Carlos", "6B")
estudiante1.promedio
estudiante1.ordenar_promedios
estudiante1.promedio_general
estudiante1.agregar_notas("matematicas", 5, 0)
curso6b = Curso.new("6B", 40)
# Mostrar estudiantes
curso6b.mostrar_estudiantes

# Mostrar el promedio general del curso
curso6b.promedio_general_curso

# Mostrar ranking de estudiantes por promedio
curso6b.ranking_estudiantes

# Mostrar promedio por asignatura en el curso
curso6b.promedio_por_asignatura
