<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<style>
/* div{
	border: 2px solid red;
}  */

.container {
    /* //max-width: 600px; */
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    //box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

 form {
    display: flex;
    flex-direction: column;
} 

label {
    margin-bottom: 8px;
}

input {
    margin-bottom: 16px;
    padding: 8px;
}

button {
    background-color: #4caf50;
    color: white;
    border: none;
    padding: 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px; 
    cursor: pointer;
}


</style>
    <!-- TEAM COMA SPACE -->
    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        <div class="container" style="text-align: center; margin-top:5px; margin-bottom: 5px;">
          <!-- coma content space -->
		<div class="container">
		    <div class="profile">
		    	<img src="https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg" alt="Profile Image" class="profile-image" style="width:200px; height:200px" >
		        <form id="profileForm">
		            <label for="username">이름:</label>
		            <input type="text" id="username" name="username" value="정우현" readonly>
		            
		            <label for="position">부서:</label>
					<select id="position" name="position" disabled>
		                <option value="manager">강사팀</option>
		                <option value="developer">행정팀</option>
		                <option value="designer">취업팀</option>
		                <option value="designer">회계팀</option>
		                <!-- Add more options as needed -->
		            </select>
		            
		            <label for="position">직책:</label>
					<select id="position" name="position" disabled>
		                <option value="manager">원장</option>
		                <option value="developer">부장</option>
		                <option value="designer">팀장</option>
		                <!-- Add more options as needed -->
		            </select>
		            
		            <label for="email">Email:</label>
		            <input type="email" id="email" name="email" value="user1@example.com" readonly>
					
		            <label for="profileImage">주소:</label>
		            <input type="text" id="profileImage" name="profileImage" value="부산 남구 용호동" readonly>
		            <button class="btn btn-primary" type="button" onclick="enableEdit()">Edit</button>
		            <button class="btn btn-primary" type="button" onclick="saveChanges()" style="display: none;">Save Changes</button>
		        </form>
		    </div>
		</div>
          <!-- coma content space -->
        </div>
    </div>
<script>
function enableEdit() {
    const form = document.getElementById('profileForm');
    const inputs = form.getElementsByTagName('input');
    const select = document.getElementById('position');

    for (let i = 0; i < inputs.length; i++) {
        inputs[i].removeAttribute('readonly');
    }

    select.removeAttribute('disabled');

    document.querySelector('button[onclick="enableEdit()"]').style.display = 'none';
    document.querySelector('button[onclick="saveChanges()"]').style.display = 'inline-block';
}

function saveChanges() {
    const form = document.getElementById('profileForm');
    const inputs = form.getElementsByTagName('input');
    const select = document.getElementById('position');

    // Save changes to the server or perform necessary actions
    
    for (let i = 0; i < inputs.length; i++) {
        inputs[i].setAttribute('readonly', true);
    }

    select.setAttribute('disabled', true);

    document.querySelector('button[onclick="enableEdit()"]').style.display = 'inline-block';
    document.querySelector('button[onclick="saveChanges()"]').style.display = 'none';
}

    
</script>
    <!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>