class TasksController < ApplicationController
  
  #A action created by the 'rails g controller Tasks index' command line function. A veiw was also automatically generated. 
  #This action transfers specifically to the index view. Rails default. 
  def index
    #Here we use the @tasks variables so that this variable is accesible in the veiw of index as well. We pass the variables all
    #the task rows from the database
    @tasks= Task.all
    #We want to be accesible in the veiw as well as in functions below. 
    @task =Task.new
  end
  
  #When a post-request is sent to the indicated page, it will look for a create function in the controller. 
  def create
    #params is the variable given by the post/get request. In php, this is equal to _POST, _GET
    #The render generates the text in a webbrowser
    #render :text => params.inspect
      
    #Creates the model using the data passed from the form. Params represents all the data, while the hash is passed with the :task as
    #the index. 
    Task.create params[:task]
    
    #The post redirects to the /task page. Here we force the browser to go back to the main veiw page. 
    redirect_to :back
  end
  
  # Routeing after edit button clicked
  def edit
    #Tasks will be set each time we have an edit. Since form is set based on @tasks, the form will be different each time. 
    @task = Task.find params[:id]
  end
  
  # Routing after update button on form (on edit veiw) clicked
  def update
    #The :id is passed in through routing. The task is a local variable. 
    task= Task.find params[:id]
    #Here we update the attribute of the approriate Task in the table with the :task provided by the routing
    #Validation is necessary here topass a false on teh first if statement. 
    if task.update_attributes params[:task]
      redirect_to tasks_path, :notice => "Your Task has been successfully updated."
    else
      # This would be to the edit page. Update triggers that we whould move away from current page. 
      #The notice is displace on the browser
      redirect_to :back, :notice => "There was an error updating your task."
    end
    
  end
  
  #the id is passed in here
  def destroy
    Task.destroy params[:id]
    redirect_to :back, :notice => "Task has been deleted. "
  end
  
end
