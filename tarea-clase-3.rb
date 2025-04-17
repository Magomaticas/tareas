class Conductor
    attr_reader :nombre
    attr_reader :edad
    attr_reader :magia
    attr_reader :horas_conduciendo
    def initialize (nombre, edad, magia=false,horas_conduciendo=0)
      @nombre = nombre
      @edad= edad
      @magia = magia
      @horas_conduciendo= horas_conduciendo
    end
  
    def presentarse
      puts "Hola soy #{@nombre}, tengo #{@edad}"
    end
  
    def manejar_auto
      if @edad>=18
       puts "Puede manejar autos" 
      else
        puts "Error: #{@nombre} no puede manejar autos"
      end
    end
  
    def aumentar_horas (n)
      @horas_conduciendo=@horas_conduciendo+n
    end
  end
  
  
  
  class Auto
    def initialize (marca,modelo,conductor=nil,magico=false)
      @marca= marca
      @modelo= modelo
      @conductor = conductor
      @magico = magico
    end
  
    def asignar_conductor (conductor)
      @conductor= conductor
      if @magico==true and @conductor.magia==true
        if @conductor.edad>=18
          puts "#{@conductor.nombre} ahora es el conductor de #{@marca} #{@modelo}"
        else 
          puts "#{@conductor.nombre} no puede manejar porque es menor de edad"
          @conductor=nil
        end
      elsif @magico==true and @conductor.magia==false
        puts "#{@conductor.nombre} no ve el #{@marca} #{@modelo}"
        @conductor=nil
      else
        if @conductor.edad>=18
          puts "#{@conductor.nombre} ahora es el conductor de #{@marca} #{@modelo}"
        else
          puts "#{@conductor.nombre} no puede manejar porque es menor de edad"
          @conductor=nil
        end
      end
  
    end
  
    def detalles
      puts "El #{@marca} #{@modelo} está en marcha con #{@conductor.nombre} al volante"
    end
  
    def conducir (n)
      if @conductor!=nil
        @conductor.aumentar_horas(n)
        puts "#{@conductor.nombre} está manejando el #{@marca} #{@modelo} hace #{@conductor.horas_conduciendo} horas"
        cansado
      else
        puts "El #{@marca} #{@modelo} no tiene conductor asignado"
      end
    end
  
    def cansado
      if @conductor.horas_conduciendo>=6
        puts "#{@conductor.nombre} está cansado de manejar"
      end
    end
  
  
  end
  
  conductor1= Conductor.new("Harry Potter", 16, true)
  conductor2= Conductor.new("Snape", 45, true)
  conductor3= Conductor.new("Maca", 30, true)
  conductor4= Conductor.new("Fernando", 29)
  conductor5= Conductor.new("Camila", 12)
  auto1=Auto.new("Autobus","Noctambulo",nil,true)
  auto2=Auto.new("Corsa","pop2")
  
  auto1.asignar_conductor(conductor2)
  auto1.conducir(6)
  
  

  