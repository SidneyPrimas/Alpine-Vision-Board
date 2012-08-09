require 'spec_helper'
#Essentially, we use this to control the user interaction with our code. 

#Refers to the Tasks controller
describe "Tasks" do
  
  before :each do
    @task = Task.create :task => "go to bed"
  end
  
  #Here we are looking at the GET request in /tasks.
  describe "GET /tasks" do
    
    it "display all tasks" do
      
      #Since we are testing, we want to pre-populate the database with a model. We do this here. 
      # @task = Task.create :task => "go to bed"
      
      #Visit is a capybara function that will help us implement the test. 'tasks_path' is a routing function that connects to HTTP
      #verbs/function. Essentially, we call the index function as defined by the controller, etc. 
      visit tasks_path
      #Looks at the task view (based on statement above that sets page to task veiw). "Go to bed" should be part of the content.
      page.should have_content "go to bed"
    end
    
    it "creates a new task" do
      visit tasks_path
      
      #If an element has an id, name or tag atribute of "Task", then we grab it and fill it in with the text. 
      fill_in 'Task', :with => "go to work"
      #Click a button. The button will be enabled to store the text box information in the database. 
      click_button 'Create Task'
      
      #Make sure that we didn't leave the page. 
      current_path.should == tasks_path
      page.should have_content "go to work"
      
      #Uses launchy gem to automatically open the browser. This is through capybara
      #save_and_open_page
    end
      
  end
  
  describe "PUT /tasks" do
    
    it "edits a task" do
      visit tasks_path
      ##Not Working!!
      page.find('#Edit').click_link
      
      # This is to check that we have re-routed to the edit page (using a PUT HTTP command) after clicking the edit button
      #Since we are putting a command, we pass in information.
      current_path.should == edit_task_path(@task)
      #The new page that we routed to will have the form page with the selected task value autopopulated. We check this here.
      # replace this page.should have_content "go to bed" with line below
      find_field('Task').value.should == 'go to bed'
      
      #Now, we tell the user to fill in the form labeled task
      fill_in "Task", :with => "updated task"
      #Now, we tell the user to save this entry
      click_button "Update Task"
      
      #Reroutes to the task_path. Checks this
      current_path.should == tasks_path
      
      #Checks if the content was added
      page.should have_content "updated task"
    end
    
    #Here we test if there is no entry on the Edit page
    it "Shoudld not Update an Empty Task" do
      visit tasks_path
      ##Not Working
      page.find('#Edit').click_link
      
      fill_in 'Task', :with=>''
      click_button 'Update Task'
      
      current_path.should == edit_task_path
      page.should have_content "There was an error updating your task."
    end
    
  end
  
  describe "Delete /tasks" do
    
    it "should delete a task" do
      #Instead of using capybara which uses click_link "name" to find the element, we use below
      find("#task_#{@task.id}").click_link "Delete"
      page.should have_content "Task has been deleted."
      page.should have_no_content "go to bed"
      
    end
  end

  
end
